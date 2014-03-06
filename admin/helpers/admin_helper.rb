module AdminHelper
  SORT_PER_PAGE = 30
  Sort = Struct.new(:column, :order, :page)

  def company_name
    "ЛенСтройИнициатива"
  end

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

  def sort_resource
    @sort = Sort.new
    @sort.column = params[:sort]  ? params[:sort]  : 'id'
    @sort.order  = params[:order] ? params[:order] : 'asc'
    @sort.page   = params[:page]  ? params[:page]  : 1
    @sort
  end

  def sort_link(model, column)
    order = sorted_by_this?(column) ? 'desc' : 'asc'
    link_to mat(model, column),
      url(:pages, :index, sort: column, order: order, page: @sort.page)
  end

  def sorted_by_this?(column)
    column.to_s == @sort.column && @sort.order == 'asc'
  end
end

Lenstroy::Admin.helpers AdminHelper