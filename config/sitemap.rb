require 'rubygems'
require 'sitemap_generator'

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://lenstroyin.ru"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  # binding.pry
  SitemapGenerator::Interpreter.send :include, Padrino::Routing
  extend ApplicationHelper
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add pricelist_url, :priority => 0.3, :changefreq => 'yearly'

  not_for_search = %w{'message'}

  Page.includes(:parent).find_each do |page|
    next if not_for_search.include? page.slug
    add sitemap_page_url(page),
      :priority => 0.5, :changefreq => 'monthly'
  end
end