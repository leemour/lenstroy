Lenstroy::App.helpers do
  def company_name
    "ЛенСтройИнициатива"
  end

  def contact_email
    "info@lenstroyin.ru"
  end

  def contact_tel
    "(812) 314-81-90"
  end

  def full_title(page)
    base_title = "#{company_name} - Строительство загородных домов"
    return base_title if page.index_page?
    title = page.seo_title.empty? ? page.title : page.seo_title
    "#{title} | #{base_title}"
  end

end