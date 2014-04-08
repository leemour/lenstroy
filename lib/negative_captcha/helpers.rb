module NegCaptcha
  module Helpers
    def self.registered(app)
      included(app)
    end

    def self.included(base)
      base.send :include, NegCaptcha::Helpers::FormBuilder
      base.send :include, NegCaptcha::Helpers::ViewHelper
    end
  end
end