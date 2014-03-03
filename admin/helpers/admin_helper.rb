Lenstroy::Admin.helpers do
  def root_pages
    pages = Page.roots.map { |parent| [parent.title, parent.id] }
    [["Нет родителя", 0]] +  pages
  end

  def page_statuses
    Page.statuses.map { |k, v| [v, k] }
  end

end