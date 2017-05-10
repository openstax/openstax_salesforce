# This initializer always runs before the engine is loaded, but it can
# also be copied to the application's initializers by running the install
# task. Because this code can get run multiple times, make sure to only put
# code here that is amenable to that.

OpenStax::Salesforce.configure do |config|
  # Layout to be used for OpenStax::Salesforce's controllers
  config.layout = 'application'

  # Proc called with an argument of the controller where this is called.
  # This proc is called when a user tries to access the engine's controllers.
  # Should raise an exception, render or redirect unless the user is a manager
  # or admin. The default renders 403 Forbidden for all users.
  config.authenticate_admin_proc = ->(controller) {
    controller.head(:forbidden)
  }

  # Consumer key and secret for connecting to the Salesforce app
  config.salesforce_client_key = 'put_real_key_value_here'
  config.salesforce_client_secret = 'put_real_secret_value_here'

  # Uncomment this to override the login site for sandbox instances; ok to be nil
  # config.salesforce_login_site = 'https://test.salesforce.com'

  # The following sandbox tokens are used for specs to connect to a sandbox Salesforce
  # instance.
  if Rails.env.test?
    config.sandbox_oauth_token = 'put_real_value_here'
    config.sandbox_refresh_token = 'put_real_value_here'
    config.sandbox_instance_url = 'put_real_value_here'
  end

  # Change this to true if you want to call the omniauth setup on your own
  config.skip_automatic_omniauth_setup = false

  # If `check_sandbox_instance_url` is true (default), the spec helper that
  # uses the instance URL will checks that the URL starts with "cs", which
  # indicates that the instance is a sandbox.
  config.check_sandbox_instance_url = true

  # A way to customize page headings.  Sometimes apps fold the page heading
  # into the layout in different ways.
  config.page_heading_proc = ->(view, text) { "<h2>#{text}</h2>".html_safe }
end


