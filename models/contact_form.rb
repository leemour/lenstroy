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
  # validates_length_of :content, :maximum => 500

  def initialize(request)
    @sent = false
    @captcha = new_captcha(request)
    @captcha.values.each do |name, value|
      send("#{name}=", value)
    end
  end

  def new_captcha(request, attrs={})
    params = symbolize_captcha_keys! request.params
    params.update attrs
    NegativeCaptcha.new(
      secret:  ENV['NEGATIVE_CAPTCHA_SECRET'],
      spinner: request.ip,
      fields:  [:name, :email, :content],
      params:  params
    )
  end

  def persisted?
    false
  end

  def is_valid?
    self.valid? && @captcha.valid?
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

  private

  def symbolize_captcha_keys!(hash)
    %w{spinner timestamp}.each do |key|
      hash[key.to_sym] = hash[key]
      hash.delete(key)
    end
    hash
  end
end