##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# or storing emails locally:
#
#   set :delivery_method, :file => {
#     :location => "#{Padrino.root}/tmp/emails",
#   }
#
# and then all delivered mail will use these settings unless otherwise specified.
#

Lenstroy::App.mailer :contact do
  email :contact_email do |name, email, content|
    receiver = Padrino.env == :production ? ENV['PROD_MAIL_TO'] : ENV['DEV_MAIL_TO']
    from    email
    to      receiver
    subject 'С сайта Lenstroy'
    locals  name: name, email: email, content: content
    content_type 'text/html'   # optional, defaults to plain/text
    via     :smtp              # optional, to smtp if defined, otherwise sendmail
    render  'contact_email'#, layout: 'email'
  end
end
