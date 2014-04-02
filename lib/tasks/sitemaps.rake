# require this file to load the tasks
require 'rake'

# Require sitemap_generator at runtime. If we don't do this the ActionView helpers are included
# before the Rails environment can be loaded by other Rake tasks, which causes problems
# for those tasks when rendering using ActionView.
namespace :sitemaps do
  # Require sitemap_generator only. When installed as a plugin the require will fail, so in
  # that case, load the environment first.
  task :generate => :environment do
    SitemapGenerator::Interpreter.run(:config_file => ENV["CONFIG_FILE"], :verbose => verbose)
  end

  desc "Install a default config/sitemap.rb file"
  task :install => :environment do
    SitemapGenerator::Utilities.install_sitemap_rb(verbose)
  end

  desc "Delete all Sitemap files in public/ directory"
  task :clean => :environment do
    SitemapGenerator::Utilities.clean_files
  end

  desc "Generate sitemaps and ping search engines."
  task :refresh => ['sitemaps:create'] do
    SitemapGenerator::Sitemap.ping_search_engines
  end

  desc "Generate sitemaps but don't ping search engines."
  task 'refresh:no_ping' => ['sitemaps:create']

  desc "Generate sitemaps but don't ping search engines. Alias for refresh:no_ping."
  task :create => :environment do
    SitemapGenerator::Interpreter.run(:config_file => ENV["CONFIG_FILE"], :verbose => verbose)
  end
end