Lenstroy::Admin.helpers do
  def root_pages
    pages = Page.roots.map { |parent| [parent.title, parent.id] }
    [["Нет родителя", 0]] +  pages
  end

  def page_statuses
    Page.statuses.map { |k, v| [v, k] }
  end

  def account_roles
    Account.roles.map { |k, v| [v, k] }
  end

  def sort_pages
    @sort_column = params[:sort]  ? params[:sort].to_sym  : :id
    @sort_order  = params[:order] ? params[:order].to_sym : :asc
    @sort_url    = request.path_info
  end

  def sort_link(model, column)
    # raise @sort_order.inspect
    order = (column == @sort_column &&
                @sort_order == :asc) ? :desc : :asc

    link_to mat(model, column), url(:pages, :index, sort: column, order: order)
  end

end