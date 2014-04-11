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

  def vk_group_url
    "http://vk.com/lenstroyin"
  end

  def promo_url(slug='')
    return '/promotions' if slug.empty?
    "/promotions/#{slug}"
  end

  def base_title
    "#{company_name} - Ремонт квартир, строительство загородных домов"
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
    '/docs/Pricelist_Lenstroyin.pdf'
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

  def setup_contact_form
    @message = ContactForm.new request
  end

  def new_captcha
    Message.new_captcha request
  end

  def contact_param
    params[:contact_form] ||= {}
    params[:contact_form].symbolize_keys!
    {name: '', email: '', content: ''}.update params[:contact_form]
  end

  def social_buttons
    capture_haml do
      haml_tag :div, class: 'social-buttons' do
        haml_tag :h4, "Поделитесь информацией с друзьями:"
        haml_tag :div, class: 'yashare-auto-init',
          'data-yashareL10n' => 'ru',
          'data-yashareQuickServices' =>
            'vkontakte,facebook,odnoklassniki,moimir,twitter',
          'data-yashareTheme' => 'counter'
      end
    end
  end
end

Lenstroy::App.helpers ApplicationHelper