module Lenstroy
  class App < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    register Sinatra::SimpleNavigation
    register SassInitializer

    register Padrino::Pipeline
    configure_assets do |assets|
      assets.pipeline = Padrino::Pipeline::Sprockets
      assets.css_assets =  [ "app/assets/css", Bootstrap.stylesheets_path ]
      assets.js_assets  =  [ "app/assets/js", Bootstrap.javascripts_path ]
      assets.image_prefix = '/images'
      assets.css_prefix = '/css'
      assets.js_prefix  = '/js'
      # assets.compiled_output = "#{public_path}"
    end

    # enable :sessions
    enable :reload

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    set :locale_path, Dir.glob(File.join(Padrino.root, 'config/locales/**/*.{rb,yml}')) # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #
    configure :development do
      require 'rack-livereload'
      use Rack::LiveReload
      disable :asset_stamp
      # set :show_exceptions, false
    end

    configure :production do
      set :haml, :ugly => :true
      set :sass, :style => :compressed
    end

    # You can manage errors like:

    # error ActiveRecord::RecordNotFound do
    #   status 404
    #   render 'errors/404', :layout => :error
    # end
    not_found do
      @title = t('custom_errors.404.title')
      status 404
      render 'errors/404', :layout => :error
    end

    error 403 do
      @title = t('custom_errors.403.title')
      render 'errors/403', :layout => :error
    end

    error 404 do
      @title = t('custom_errors.404.title')
      render 'errors/404', :layout => :error
    end

    error 500 do
      @title = t('custom_errors.500.title')
      render 'errors/500', :layout => :error
    end
  end
end
