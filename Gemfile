source 'https://rubygems.org'

# Project requirements
gem 'padrino', '0.12.0'
gem 'rake'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'sass'
gem 'haml'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3'
gem 'puma'
gem 'kaminari', :require => 'kaminari/sinatra'
gem 'simple-navigation', git: 'git@github.com:codeplant/simple-navigation.git'
gem 'sinatra-simple-navigation', :require => 'sinatra/simple-navigation'
gem 'sitemap_generator'
# gem 'negative_captcha'

# Assets
gem 'bootstrap-sass'
gem 'padrino-pipeline', git: 'git@github.com:Ortuna/padrino-pipeline.git'

# Image uploads
gem 'carrierwave'
gem 'mini_magick'

group :development, :test do
  gem 'capistrano', '>= 3.1', require: false
  # gem 'foreman'
  gem 'pry-byebug'
  gem 'guard-rspec'
  gem 'guard-cucumber'

  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :production do
  gem 'newrelic_rpm'
end

group :test do
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'capybara'
  gem 'cucumber'
  gem 'rack-test', :require => 'rack/test'
  #system-dependent notifications (uncomment for a team)
  gem 'rb-inotify', :require => false
  #gem 'rb-fsevent', :require => false
  #gem 'rb-fchange', :require => false
end

# JSON codec (faster performance)
# gem 'oj'