namespace :assets do
  desc 'Compile all assets'
  task :compile => [:compile_js, :compile_css] do
  end

  desc 'Compile JS assets for Admin and App'
  task :compile_js => [:compile_app_js, :compile_admin_js] do
  end

  desc 'Compile CSS assets for Admin ONLY'
  task :compile_css => [:compile_admin_css] do
  end

  desc 'Compile App JS assets'
  task :compile_app_js => :environment do
    sprockets.append_path File.join PADRINO_ROOT, 'app', 'assets', 'js'
    sprockets.append_path File.join Bootstrap.gem_path, 'vendor', 'assets', 'javascripts'
    outpath = File.join PADRINO_ROOT, 'public', 'js', 'application.js' #use the digest in the future?

    asset = sprockets['application.js']
    asset.write_to(outpath)
    # asset.write_to("#{outpath}.gz")
    puts "successfully compiled App JS assets"
  end

  desc 'Compile Admin JS assets'
  task :compile_admin_js => :environment do
    sprockets.append_path File.join PADRINO_ROOT, 'admin', 'assets', 'js'
    outpath = File.join PADRINO_ROOT, 'public', 'admin', 'js', 'admin.js'

    asset = sprockets['admin.js']
    asset.write_to(outpath)
    puts "successfully compiled Admin JS assets"
  end

  desc 'Compile App CSS assets'
  task :compile_app_css => :environment do
    sprockets.append_path File.join PADRINO_ROOT, 'app', 'assets', 'css'
    outpath = File.join PADRINO_ROOT, 'public', 'css', 'application.css'

    sprockets.css_compressor = :sass
    asset = sprockets['application.sass']
    asset.write_to(outpath)
    puts "successfully compiled App CSS assets"
  end

  desc 'Compile Admin CSS assets'
  task :compile_admin_css => :environment do
    sprockets.append_path File.join PADRINO_ROOT, 'admin', 'assets', 'css'
    outpath = File.join PADRINO_ROOT, 'public', 'admin', 'css', 'admin.css'

    asset = sprockets['admin.sass']
    asset.write_to(outpath)
    puts "successfully compiled Admin CSS assets"
  end
  # TODO: add :clean_all, :clean_css, :clean_js tasks, invoke before writing new file(s)
end

def sprockets
  @sprockets ||= Sprockets::Environment.new(PADRINO_ROOT) do |env|
    env.logger = Logger.new(STDOUT)
  end
end