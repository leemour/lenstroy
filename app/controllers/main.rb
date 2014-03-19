Lenstroy::App.controller do
  before do
    @message = ContactMessage.new(params[:message])
  end

  get :index do
    @page = Page.find_by_slug('index')
    render 'pages/index'
  end

  get '/mail-sent' do
    @page = Page.find_by_slug('mail-sent')
    render 'pages/mail-sent'
  end

  get '/:primary', priority: :low do
    @page = Page.primary(params[:primary])
    halt 404 unless @page
    render 'pages/page'
  end

  get '/:primary/:secondary', priority: :low do
    @page = Page.secondary(params[:first], params[:second])
    halt 404 unless @page
    render 'pages/page'
  end
end