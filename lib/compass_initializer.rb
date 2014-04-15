# http://compass-style.org/help/tutorials/configuration-reference/

module CompassInitializer
  module App
    def self.registered(app)
      require 'sass/plugin/rack'

      Compass.configuration do |config|
        config.project_path    = Padrino.root
        config.sass_dir        = "app/assets/css"
        config.css_dir         = "public/css"
        config.images_dir      = "public/images"
        config.javascripts_dir = "public/js"
        config.http_path       = "/"
        config.project_type = :stand_alone
        config.output_style = :compressed
      end

      Compass.configure_sass_plugin!
      Compass.handle_configuration_change!

      Sass::Plugin.options[:template_location] = Padrino.root("app/assets/css")
      Sass::Plugin.options[:css_location] = Padrino.root("public/css")
      app.use Sass::Plugin::Rack
    end
  end

  module Admin
    def self.registered(app)
      require 'sass/plugin/rack'

      Compass.configuration do |config|
        config.project_path    = Padrino.root
        config.sass_dir        = "admin/assets/css"
        config.css_dir         = "public/admin/css"
        config.images_dir      = "public/admin/images"
        config.javascripts_dir = "public/admin/js"
        config.http_path       = "/admin/"
        config.project_type = :stand_alone
        config.output_style = :compressed
      end

      Compass.configure_sass_plugin!
      Compass.handle_configuration_change!

      # Sass::Plugin.options[:template_location] = Padrino.root("admin/assets/css")
      # Sass::Plugin.options[:css_location] = Padrino.root("public/admin/css")
      app.use Sass::Plugin::Rack
    end
  end
end