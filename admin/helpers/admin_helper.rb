module AdminHelper
  def company_name
    "ЛенСтройИнициатива"
  end

  def root_pages
    pages = Page.roots.select(:title, :id, :slug).map do |parent|
      ["#{rpad parent.title, 16} /#{parent.slug}".html_safe, parent.id]
    end
    [["Нет родителя", 0]] +  pages
  end

  def root_pages_list
    list = root_pages
    list.delete_if {|item| item[1] == 1} # delete index page
    list[0] = ['Все', -1]
    list
  end

  def rpad(string, length)
    string.ljust(length, '*').gsub('*', '&nbsp;')
  end

  def page_statuses
    Page.statuses.map { |k, v| [v, k] }
  end

  def account_roles
    Account.roles.map { |k, v| [v, k] }
  end

  def sort_resource
    @sort = params[:sort] ? params[:sort].symbolize_keys : {}
    @sort[:column] ||= 'id'
    @sort[:order]  ||= 'asc'
    @sort[:page]   ||= 1
    @sort
  end

  def filter_resource
    @filter = params[:filter] ? params[:filter].symbolize_keys : {}
    @filter[:name] ||= ''
    @filter[:type] ||= ''
    @filter
  end

  def sort_link(model, column)
    order = sorted_by_this?(column) ? 'desc' : 'asc'
    link_to sort_header(model, column, order),
      url(model.to_s.pluralize.to_sym, :index, filter: @filter,
        sort: @sort.merge(column: column, order: order))
  end

  def sorted_by_this?(column)
    column.to_s == @sort[:column] && @sort[:order] == 'asc'
  end

  def sort_header(model, column, order)
    klass = order == 'asc' ? '' : 'caret-reversed'
    caret = "<span class='caret caret-sort #{klass}'></span>"
    header = mat(model, column)
    (header + caret).html_safe
  end

  def filter_link(filter, model)
    klass = 'btn'
    klass += ' active' if @filter[:name] == filter[:name]
    link_to pat(filter[:name]),
      url(model, :index, sort: @sort, filter: filter), class: klass
  end

  def filter_selected?(page)
    @filter[:name].to_i == page[1]
  end

  def parent_filter_uri(page)
    uri = url(:pages, :index, sort: @sort, filter: {type: :parent, name: page[1]})
  end

  def upload_url
    '/admin' + UploadedImage::UPLOAD_PATH
  end
end

Lenstroy::Admin.helpers AdminHelper