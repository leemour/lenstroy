# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Padrino
  #   App
  watch(%r{app/assets/css/.+\.(css|sass|scss)}) { "/public/css/application.css" }
  watch(%r{app/assets/js/.+\.(js|coffee)})      { "/public/js/application.js" }
  #   Admin
  watch(%r{admin/assets/css/.+\.(css|sass|scss)}) { "/public/admin/css/admin.css" }
  watch(%r{admin/assets/js/.+\.(js|coffee)})      { "/public/admin/js/application.js" }

  # Rails Assets Pipeline
  # watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
