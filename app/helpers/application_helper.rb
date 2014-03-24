module ApplicationHelper
  def company_name
    "ЛенСтройИнициатива"
  end

  def contact_email
    "info@lenstroyin.ru"
  end

  def support_email
    "support@lenstroyin.ru"
  end

  def contact_tel
    "(812) 938-21-10"
  end

  def base_title
    "#{company_name} - Строительство загородных домов"
  end

  def full_title(page)
    if page.is_a? Page
      return base_title if page.index_page?
      title = page.seo_title.empty? ? page.title : page.seo_title
    else
      title = page
    end
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

  def sitemap_page_url(page)
    path = '/'
    page.slug = '' if page.slug == 'index'
    if page.parent
      path + page.parent.slug + '/' + page.slug
    else
      path + page.slug
    end
  end

  def tag_icon(icon, tag = nil)
    content = content_tag(:span, '', :class=> "glyphicon glyphicon-#{icon}")
    content << " #{tag}"
  end
end

Lenstroy::App.helpers ApplicationHelper