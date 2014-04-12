module Lenstroy
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    register SassInitializer
    register Kaminari::Helpers::SinatraHelpers

    register Padrino::Pipeline
    configure_assets do |assets|
      assets.pipeline = Padrino::Pipeline::Sprockets
      assets.css_assets =  [ "admin/assets/css", Bootstrap.stylesheets_path ]
      assets.js_assets  =  [ "admin/assets/js", Bootstrap.javascripts_path ]
      assets.image_prefix = '/images'
      assets.css_prefix = '/css'
      assets.js_prefix  = '/js'
      # assets.compiled_output = "#{public_path}"
    end

    ##
    # Application configuration options
    #
    # set :raise_errors, true         # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true          # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true      # Shows a stack trace in browser (default for development)
    # set :logging, true              # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, "foo/bar"   # Location for static assets (default root/public)
    # set :reload, false              # Reload application files (default in development)
    # set :default_builder, "foo"     # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"         # Set path for I18n translations (default your_app/locales)
    # disable :sessions               # Disabled sessions by default (enable if needed)
    # disable :flash                  # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout              # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :admin_model, 'Account'
    set :login_page,  '/sessions/new'

    # enable  :sessions
    disable :store_location
    enable  :reload

    configure :development do
      disable :asset_stamp
    end

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
      role.project_module :projects, '/projects'
      role.project_module :pages, '/pages'
      role.project_module :accounts, '/accounts'
    end

    access_control.roles_for :editor do |role|
      role.project_module :pages, '/pages'
      role.project_module :accounts, '/accounts'
    end

    access_control.roles_for :writer do |role|
      role.project_module :pages, '/pages'
    end

    # Custom error management
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
