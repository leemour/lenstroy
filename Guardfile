# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Padrino
  # watch(%r{(app|vendor)/assets(/\w+/.+\.(css|sass|scss|js|coffee))}) { |m| "#{m[3]}" }
  watch(%r{app/assets/stylesheets/.+\.(css|sass|scss)}) { "/stylesheets/application.css" }
  watch(%r{app/assets/javascripts(/(?<!bootstr)(\w+/)?.+\.(js|coffee))}) { "/javascripts/application.js" }
  watch(%r{app/assets/javascripts/bootstrap/.+\.(js|coffee)}) { "/javascripts/bootstrap.js" }

  watch(%r{admin/assets/stylesheets/.+\.(css|sass|scss)}) { "public/admin/stylesheets/admin.css" }
  watch(%r{admin/assets/javascripts(/(?<!bootstr)(\w+/)?.+\.(js|coffee))}) { "/admin/javascripts/application.js" }
  watch(%r{app/assets/javascripts/bootstrap/.+\.(js|coffee)}) { "/javascripts/bootstrap.js" }

  # Rails Assets Pipeline
  # watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
