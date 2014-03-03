Lenstroy::App.controller do
  get :index do
    @page = Page.find_by_slug(:index)
    render 'pages/index'
  end

  get '/mail-sent' do
    @page = Page.find_by_slug('mail-sent')
    render 'pages/mail-sent'
  end

  get '/:primary', priority: :low do
    @page = Page.primary(params[:primary])
    render 'pages/page'
  end

  get '/:primary/:secondary', priority: :low do
    @page = Page.secondary(params[:first], params[:second])
    if @page
      render 'pages/page'
    else
      halt 404
    end
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
end