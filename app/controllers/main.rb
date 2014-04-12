Lenstroy::App.controller do
  before do
    setup_contact_form
  end

  get :index do
    @page = Page.find_by_slug('index')
    halt 404 unless @page
    render 'pages/index'
  end

  get '/promotions' do
    @page = Page.find_by_slug('promotions')
    @promotions = Page.children_of('promotions')
    halt 404 unless @page
    render 'pages/promotions'
  end

  get '/projects' do
    @page = Page.find_by_slug('projects')
    @projects = Projects.all
    halt 404 unless @page
    render 'pages/projects'
  end

  get '/:primary', priority: :low do
    @page = Page.primary(params[:primary])
    halt 404 unless @page
    render 'pages/page'
  end

  get '/:primary/:secondary', priority: :low do
    @page = Page.secondary(params)
    halt 404 unless @page
    render 'pages/page'
  end

  get '/500' do
    halt 500
  end
end