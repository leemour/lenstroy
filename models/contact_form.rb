class ContactForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming

  attr_accessor :name, :email, :content, :captcha

  validates_presence_of :name, :email, :content
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_length_of :name, :maximum => 50
  validates_length_of :content, :maximum => 500

  def initialize(attributes = {})
    return false unless attributes
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @attributes = attributes
    @sent       = false
    # @captcha = NegativeCaptcha.new(
    #   :secret => ENV['NEGATIVE_CAPTCHA_SECRET'], #from config/secret.rb
    #   :spinner => request.ip,
    #   :fields => [:name, :email, :content], #Whatever fields are in your form
    #   :params => params
    # )
  end

  def persisted?
    false
  end

  def deliver
    if Lenstroy::App.deliver(:contact, :contact_email, name, email, content)
      @sent = true
    end
    @sent
  end

  def sent?
    @sent
  end
end