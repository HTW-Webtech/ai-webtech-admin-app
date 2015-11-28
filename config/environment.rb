# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name:            ENV.fetch('SENDGRID_USER'),
  password:             ENV.fetch('SENDGRID_PASSWORD'),
  domain:               cc(:site).hostname,
  address:              'smtp.sendgrid.net',
  port:                 587,
  authentication:       :plain,
  enable_starttls_auto: true
}

ActionMailer::Base.default_options = {
  from: "no-reply@#{cc(:site).hostname}",
  reply_to: "no-reply@#{cc(:site).hostname}"
}
