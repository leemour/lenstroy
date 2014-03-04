RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require_relative 'factories'
DatabaseCleaner.strategy = :truncation

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods
  conf.formatter = :documentation # :progress, :html, :textmate
  conf.color_enabled = true
  # Use color not only in STDOUT but also in pagers and files
  conf.tty = true
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
  @app ||= Padrino.application
end
