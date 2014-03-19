Lenstroy::App.controller :contacts do
  before :contacts, :contacts_message do
    setup_negative_captcha
  end

  get :contact, map: '/about/contacts', priority: :high do
    @page = Page.find_by_slug(:contacts)
    @message = ContactMessage.new
    render 'pages/contacts'
  end

  post :message, map: '/about/contacts' do
    @message = ContactMessage.new(@captcha.values) #Decrypted params
    if @captcha.valid? && @message.valid?
      @error = ContactMailer.contact_message(@message).deliver
      redirect_to '/mail-sent'
    else
      @page = Page.find_by_slug(:contacts)
      render 'pages/contacts'
    end
  end

  private

  # Initialize contact form  captcha
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      :secret => ENV['NEGATIVE_CAPTCHA_SECRET'], #from config/secret.rb
      :spinner => request.ip,
      :fields => [:name, :email, :content], #Whatever fields are in your form
      :params => params
    )
  end
end
