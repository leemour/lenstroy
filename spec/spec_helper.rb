RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# $LOAD_PATH << "#{Padrino.root}/admin/helpers"
load_paths = %w[admin/helpers
                app/helpers
                lib]
load_paths.each do |path|
  Dir["#{Padrino.root}/#{path}/*.rb"].each {|file| require file }
end

require_relative 'factories'
DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.formatter = :documentation # :progress, :html, :textmate
  config.color_enabled = true
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    FactoryGirl.lint
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Lenstroy::App
#   app Lenstroy::App.tap { |a| }
#   app(Lenstroy::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Lenstroy::Admin
  @app.register Padrino::Helpers
  @app.register Padrino::Rendering
  # register Padrino::Rendering
  #   register Padrino::Mailer
  #   register Padrino::Helpers
  #   register Padrino::Admin::AccessControl
  @app
end
