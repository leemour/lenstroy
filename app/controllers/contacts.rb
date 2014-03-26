Lenstroy::App.controller :contacts, map: 'about' do
  before do
    setup_contact_form
  end

  get :contacts, priority: :high do
    @page = Page.find_by_slug(:contacts)
    render 'pages/contacts'
  end

  post :message do
    # raise params.inspect
    @message.deliver if @message.valid? #&& @captcha.valid?
    @page = Page.find_by_slug(:message)
    render 'pages/message'
  end
end
