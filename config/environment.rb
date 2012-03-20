# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
JobmeApp::Application.initialize!

JobmeApp::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "localhost",
    :port                 => 25,
    :domain               => 'jobme.com' }
end
