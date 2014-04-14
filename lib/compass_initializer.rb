# Enables support for Compass, a stylesheet authoring framework based on SASS.
# See http://compass-style.org/ for more details.
# Store Compass/SASS files (by default) within 'app/stylesheets'

module CompassInitializer
  module Main
    def self.registered(app)
      require 'sass/plugin/rack'

      Compass.configuration do |config|
        config.project_path = Padrino.root
        config.sass_dir = "app/assets/stylesheets"
        config.project_type = :stand_alone
        config.http_path = "/"
        config.css_dir = "public/stylesheets"
        config.images_dir = "public/images"
        config.javascripts_dir = "public/javascripts"
        config.output_style = :compressed
      end

      Compass.configure_sass_plugin!
      Compass.handle_configuration_change!

      # app.use Sass::Plugin::Rack
      # require 'sass/plugin/rack'
      Sass::Plugin.options[:template_location] = Padrino.root("app/assets/stylesheets")
      Sass::Plugin.options[:css_location] = Padrino.root("public/stylesheets")
      app.use Sass::Plugin::Rack
    end
  end

  module Admin
    def self.registered(app)
      require 'sass/plugin/rack'

      Compass.configuration do |config|
        config.project_path = Padrino.root
        config.sass_dir = "admin/stylesheets"
        config.project_type = :stand_alone
        config.http_path = "/"
        config.css_dir = "public/admin/stylesheets"
        config.images_dir = "public/admin/mages"
        config.javascripts_dir = "public/admin/javascripts"
        config.output_style = :compressed
      end

      Compass.configure_sass_plugin!
      Compass.handle_configuration_change!

      app.use Sass::Plugin::Rack
    end
  end
end