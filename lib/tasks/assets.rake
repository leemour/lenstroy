namespace :assets do
  desc 'compile assets'
  task :compile => [:compile_js, :compile_css] do
  end

  desc 'compile javascript assets'
  task :compile_js => :environment do
    sprockets = Sprockets::Environment.new(PADRINO_ROOT) do |env|
      env.logger = Logger.new(STDOUT)
    end
    sprockets.append_path File.join PADRINO_ROOT, 'app', 'assets', 'js'
    sprockets.append_path File.join Bootstrap.gem_path, 'vendor', 'assets', 'javascripts'
    outpath = File.join PADRINO_ROOT, 'public', 'js', 'application.js'

    asset = sprockets['application.js']
    asset.write_to(outpath)
    # asset.write_to("#{outpath}.gz")
    puts "successfully compiled js assets"
  end

  # desc 'compile css assets'
  # task :compile_css do
  #   sprockets = Application.settings.sprockets
  #   asset = sprockets['application.css']
  #   outpath = File.join(Application.settings.assets_path, 'css')
  #   outfile = Pathname.new(outpath).join('application.min.css') # may want to use the digest in the future?

  #   FileUtils.mkdir_p outfile.dirname

  #   asset.write_to(outfile)
  #   asset.write_to("#{outfile}.gz")
  #   puts "successfully compiled css assets"
  # end
  # todo: add :clean_all, :clean_css, :clean_js tasks, invoke before writing new file(s)
end