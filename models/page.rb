class Page < ActiveRecord::Base
  belongs_to :account
  belongs_to :parent,   class_name: 'Page', foreign_key: 'parent_id'
  has_many   :children, class_name: 'Page'

  validates_presence_of :title
  validates_presence_of :content
  validates_uniqueness_of :slug

  scope :published, -> { where(status: :published) }

  def self.primary(slug)
    page = where(slug: slug, parent_id: 0).published.first
    page.seoize if page
  end

  def self.secondary(params)
    # TODO: submit issue and fix this ugliness
    if params[:primary].is_a? Array
      parent, child = *params[:primary]
    else
      parent = params[:primary]
      child  = params[:secondary]
    end
    page = where(slug: child).published.first
    page.seoize if page && page.parent && page.parent.slug == parent
  end

  def self.roots
    where(parent_id: 0)
  end

  def self.filter_by(filter)
    case
    when filter[:name] == 'roots'
      Page.roots
    when filter[:name] == 'promotions'
      Page.joins(:parent).where(parents_pages: {slug: filter[:name]})
    when filter[:type] == 'parent' && filter[:name].to_i > -1
      Page.where(parent_id: filter[:name])
    else
      scoped
    end
  end

  def self.sort_by(sort)
    order(sort[:column] => sort[:order].to_sym).page(sort[:page])
  end

  def self.statuses
    {published: 'опубликовано', draft: 'черновик'}
  end

  def self.filters
    [
      {name: 'all', type: 'simple'},
      {name: 'roots', type: 'simple'},
      {name: 'promotions', type: 'simple'},
    ]
  end

  def status
    real_status = read_attribute(:status)
    self.class.statuses[real_status.to_sym] if real_status
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
