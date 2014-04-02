module AdminHelper
  Sort = Struct.new(:column, :order, :page)

  def company_name
    "ЛенСтройИнициатива"
  end

  def root_pages
    pages = Page.roots.select(:title, :id, :slug).map do |parent|
      ["#{parent.title}  &nbsp;/#{parent.slug}".html_safe, parent.id]
    end
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
    link_to sort_header(model, column, order),
      url(:pages, :index,
        sort: column, order: order, page: @sort.page)
      #   sort: column, order: order, page: @sort.page, format: :js),
      # remote: true
  end

  def sorted_by_this?(column)
    column.to_s == @sort.column && @sort.order == 'asc'
  end

  def sort_header(model, column, order)
    klass = order == 'asc' ? '' : 'caret-reversed'
    caret = "<span class='caret caret-sort #{klass}'></span>"
    header = mat(model, column)
    (header + caret).html_safe
  end

  def sort_params
    params.select {|k,v| AdminHelper::Sort.members.include? k || k == :column }
  end

  def upload_url
    '/admin' + UploadedImage::UPLOAD_PATH
  end
end

Lenstroy::Admin.helpers AdminHelper