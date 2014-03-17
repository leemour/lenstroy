Lenstroy::Admin.controllers :pages do
  before :index do
    sort_resource
  end

  get :index, provides: [:html, :js] do
    @title = pat("Pages")
    @pages = Page.sorted_by(@sort)
    case content_type
    when :html
      render 'pages/index'
    when :js
      # "$('#list tbody').html('#{partial "/pages/pages"}');".to_json
      # "$('#list tbody').html('');" # working
      (partial "/pages/pages").to_json
      # html = partial '/pages/pages'
      # {params: sort_params, html: html.to_s}.to_json
    end
  end

  get :new do
    @title = pat(:new_title, :model => pat('page'))
    @page = Page.new
    render 'pages/new'
  end

  post :create do
    @page = Page.new(params[:page])
    @page.account = current_account
    if @page.save
      @title = pat(:create_title, :model => "#{pat('page')} #{@page.id}")
      flash[:success] = pat(:create_success, :model => pat('Page'))
      params[:save_and_continue] ? redirect(url(:pages, :index)) : redirect(url(:pages, :edit, :id => @page.id))
    else
      @title = pat(:create_title, :model => pat('page'))
      flash.now[:error] = pat(:create_error, :model => pat('page'))
      render 'pages/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "#{pat('page')} #{params[:id]}")
    @page = Page.find(params[:id])
    if @page
      render 'pages/edit'
    else
      flash[:warning] = pat(:create_error, :model => pat('page'), :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "#{pat('page')} #{params[:id]}")
    @page = Page.find(params[:id])
    if @page
      if @page.update_attributes(params[:page])
        flash[:success] = pat(:update_success, :model => pat('Page'), :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:pages, :index)) :
          redirect(url(:pages, :edit, :id => @page.id))
      else
        flash.now[:error] = pat(:update_error, :model => pat('page'))
        render 'pages/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => pat('page'), :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = pat("Pages")
    page = Page.find(params[:id])
    if page
      if page.destroy
        flash[:success] = pat(:delete_success, :model => pat('Page'), :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => pat('page'))
      end
      redirect url(:pages, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => pat('page'), :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = pat("Pages")
    unless params[:page_ids]
      flash[:error] = pat(:destroy_many_error, :model => pat('page'))
      redirect(url(:pages, :index))
    end
    ids = params[:page_ids].split(',').map(&:strip)
    pages = Page.find(ids)

    if Page.destroy pages

      flash[:success] = pat(:destroy_many_success, :model => pat('Pages'), :ids => "#{ids.to_sentence}")
    end
    redirect url(:pages, :index)
  end
end
