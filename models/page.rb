class Page < ActiveRecord::Base
  belongs_to :account
  belongs_to :parent,   class_name: 'Page', foreign_key: 'parent_id'
  has_many   :children, class_name: 'Page'

  validates_presence_of :title
  validates_presence_of :content
  validates_uniqueness_of :slug

  def self.primary(slug)
    page = where(slug: slug, parent_id: 0).first
    page.seoize if page
  end

  def self.secondary(params)
    parent, child = *params
    page = find_by_slug(child)
    page.seoize if page && page.parent && page.parent.slug == parent
  end

  def self.roots
    where(parent_id: 0)
  end

  def self.sorted_by(sort)
    Page.order(sort.column => sort.order.to_sym).page(sort.page)
  end

  def self.statuses
    {published: 'опубликовано', draft: 'черновик'}
  end

  def status
    status = read_attribute(:status)
    self.class.statuses[status.to_sym] if status
  end

  def seoize
    seo_desc  ||= 'Строительство загородных домов'
    seo_keys  ||= 'строительство,загородный дом,коттеджи,бани,струбы'
    seo_title ||= title
    self
  end

  def seo_column
    %i[seo_desc seo_keys seo_title].map do |info|
      send(info).empty? ? ' – ' : ' ✔ '
    end.join('')
  end

  def index_page?
    slug == 'index'
  end

  def contact_page?
    slug == 'contacts'
  end
end
