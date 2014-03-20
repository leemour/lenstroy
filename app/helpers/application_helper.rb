Lenstroy::App.helpers do
  def company_name
    "ЛенСтройИнициатива"
  end

  def contact_email
    "info@lenstroyin.ru"
  end

  def contact_tel
    "(812) 938-21-10"
  end

  def full_title(page)
    base_title = "#{company_name} - Строительство загородных домов"
    return base_title if page.index_page?
    title = page.seo_title.empty? ? page.title : page.seo_title
    "#{title} | #{base_title}"
  end

  def pricelist_url
    '/docs/Lenstroyin_Pricelist_2014.pdf'
  end

  def latest_image(name, alt_text)
    partial 'common/recent_work', locals: {name: name, alt_text: alt_text}
  end

  def min
    Padrino.env == :production ? ".min" : ""
  end
end