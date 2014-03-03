class Page < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Page'
  belongs_to :account

  validates_presence_of :title
  validates_presence_of :content

  def self.primary(slug)
    where(slug: slug, parent_id: 0).first.seoize
  end

  def self.secondary(parent, child)
    page = find_by_slug(child)
    page.seoize if page && page.parent.slug == parent
  end

  def self.roots
    where(parent_id: 0)
  end

  def self.statuses
    {published: 'опубликовано', draft: 'черновик'}
  end

  def status
    self.class.statuses[read_attribute(:status).to_sym]
  end

  def seoize
    seo_desc  ||= 'Строительство загородных домов'
    seo_keys  ||= 'строительство,загородный дом,коттеджи,бани,струбы'
    seo_title ||= title
    self
  end

  def index_page?
    slug == 'index'
  end
end
