require_relative 'secret'

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'lenstroy'
set :repo_url, 'git@github.com:leemour/lenstroy.git'

# Set Rack environment
set :rack_env, :production

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
set :linked_files, %W{
  config/database.rb
  config/secret.rb
  config/puma.rb
  db/#{fetch :application}_#{fetch :rack_env}.db
}

# Default value for linked_dirs is []
set :linked_dirs, %w{
  bin
  log
  tmp/pids tmp/cache tmp/sockets
  vendor/bundle
  public/system public/uploads
}

# Shared dirs to be created
set :create_shared_dirs, %w{
  config
  db
  public
}

# Shared dirs to be uploaded
set :shared_dirs, %w{
  bin/.
  public/uploads/.
}

# Shared config files to be uploaded and linked
set :shared_files, [
  {from: 'config/database.rb',       to: 'config/database.rb'},
  {from: 'config/secret.rb',         to: 'config/secret.rb'},
  {from: 'config/shared/monit',      to: 'config/monit'},
  {from: 'config/shared/puma.rb',    to: 'config/puma.rb'},
  {from: 'config/shared/puma.sh',    to: 'config/puma.sh'},
  {from: 'config/shared/nginx_staging.conf',    to: 'config/nginx_staging.conf'},
  {from: 'config/shared/nginx_production.conf', to: 'config/nginx_production.conf'},
]

# Make config files executable
set :executable_files, %w{
  config/puma.sh
}

# Make some files writeable
set :writable_files, []# %W{
#   db/#{fetch :application}_#{fetch :rack_env}.db
# }

# Create files unless they exist
set :touch_files, %w{
  puma.sock
  log/nginx_access.log
  log/nginx_error.log
  log/puma.log
  log/puma.err.log
  log/newrelic_agent.log
}

# Symlink config files to system paths
set :symlinks, [
  {
    from: "config/nginx_#{fetch :stage}.conf",
    to:   "/etc/nginx/sites-enabled/#{fetch :full_app_name}"
  },
  {
    from: "config/monit",
    to:   "/etc/monit/conf.d/#{fetch :full_app_name}.conf"
  },
  {
    from: "config/puma.sh",
    to:   "/etc/init.d/puma_#{fetch :application}"
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

# Setup rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch :rbenv_path} RBENV_VERSION=#{fetch :rbenv_ruby} #{fetch :rbenv_path}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Setup Bundler
set :bundle_bins, fetch(:bundle_bins, []) + %w{puma}

# New Relic
# TODO: recipe not updated to Capistrano 3, using capistrano/newrelic but
#   it fails with 'app doesn't exist'
# set :newrelic_appname,    ENV["NEW_RELIC_APP_NAME"]
# set :newrelic_license_key, ENV["NEW_RELIC_LICENSE_KEY"]

namespace :deploy do
  before :deploy, "check:revision"
  # before :finished, 'newrelic:notice_deployment'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke "puma:restart"
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

namespace :puma do
  %w[start stop restart].each do |command|
    desc "#{command} puma server"
    task command do
      on roles(:app) do
        within current_path do
          # run "/etc/init.d/unicorn_#{application} #{command}"
          execute "service puma_#{fetch :application} #{command} #{fetch :stage}"
        end
      end
    end
  end
end