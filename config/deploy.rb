require_relative 'secret'

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'lenstroy'
set :repo_url, 'git@github.com:leemour/lenstroy.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :full_app_name, "#{fetch :application}_#{fetch :stage}"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/srv/www/#{fetch :full_app_name}"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{
  config/database.rb
  config/secret.rb
}

# Default value for linked_dirs is []
set :linked_dirs, %w{
  bin
  log
  tmp/pids tmp/cache tmp/sockets
  vendor/bundle
  public/system public/uploads
}

# Shared dirs to be created in shared
set :shared_files, %w{config db public}

# Shared config files
set :shared_files, [
  {from: 'config/database.rb',       to: 'config/database.rb'},
  {from: 'config/secret.rb',         to: 'config/secret.rb'},
  {from: 'config/shared/nginx.conf', to: 'config/nginx.conf'},
  {from: 'config/shared/monit',      to: 'config/monit'},
  {from: 'public/uploads',           to: 'public/uploads'},
]

# Make config files executable
set :executable_config_files, []

# Symlink config files to system paths
set :symlinks, [
  {
    from: "config/nginx.conf",
    to:   "/etc/nginx/sites-enabled/#{fetch :full_app_name}"
  },
  {
    from: "config/monit",
    to:   "/etc/monit/conf.d/#{fetch :full_app_name}.conf"
  }
]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# SSH
set :ssh_options, {
  forward_agent: true,
  port: ENV["REMOTE_PORT"]
}

# Setup rvm.
set :rbenv_type, :system
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch :rbenv_path} RBENV_VERSION=#{fetch :rbenv_ruby} #{fetch :rbenv_path}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Set App environment
set :padrino_env, :production

# set(:newrelic_key) { "#{ newrelic_key }" }
# after "deploy:update", "newrelic:notice_deployment"

namespace :deploy do
  before :deploy, "deploy:check_revision"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :deploy do
  desc "Copy config files to remote shared. Create shared folders"
  task :setup_config do
    on roles(:app) do
      fetch(:shared_dirs).each do |dir|
        execute :mkdir, "-p #{shared_path}/#{dir}"
      end

      fetch(:shared_files).each do |file|
        file_to = "#{shared_path}/#{file[:to]}"

        if File.exist? file[:from]
          upload! file[:from], file_to
          info "copying: #{file[:from]} to: #{file_to}"
        else
          error "error #{file[:from]} not found"
        end
      end

      # which of the above files should be marked as executable
      fetch(:executable_config_files).each do |file|
        execute :chmod, "+x #{shared_path}/config/#{file}"
      end

      # symlink stuff which should be... symlinked
      fetch(:symlinks).each do |link|
        sudo "ln -nfs #{shared_path}/config/#{link[:source]} #{link[:link]}"
      end
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    branch = fetch(:branch)
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes or make sure you've"
      puts "checked out the branch: #{branch} as you can only deploy"
      puts "if you've got the target branch checked out"
      exit
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end
end

# namespace :monit
#   task :install do
#     sudo "apt-get -y install monit"
#   end
#   after "deploy:install", "monit:install"

#   desc "Setup general Monit config"
#   task :setup do
#     on roles(:app) do
#       monit_config "monit", "/etc/monit/conf.d/#{fetch :full_app_name}.conf"
#       invoke :syntax
#       invoke :reload
#     end
#   end

#   %w[start stop restart syntax reload].each do |command|
#     desc "Run Monit #{command} script"
#     task command do
#       sudo "service monit #{command}"
#     end
#   end
# end

# def monit_config(name, destination = nil)
#   destination ||= "/etc/monit/conf.d/#{name}.conf"
#   sudo "ln -nfs #{shared_path}/config/#{name} #{destination}"
#   sudo "chown root #{destination}"
#   sudo "chmod 600 #{destination}"
# end

# namespace :logs do
#   task :tail, :file do |t, args|
#     if args[:file]
#       on roles(:app) do
#         execute "tail -f #{shared_path}/log/#{args[:file]}.log"
#       end
#     else
#       puts "please specify a logfile e.g: 'rake logs:tail[logfile]"
#       puts "will tail 'shared_path/log/logfile.log'"
#       puts "remember if you use zsh you'll need to format it as:"
#       puts "rake 'logs:tail[logfile]' (single quotes)"
#     end
#   end
# end