OpenStax::Salesforce.configure do |config|

  # Engine Configuration: Must be set in an initializer

  # Layout to be used for OpenStax::Salesforce's controllers
  # Default: 'application'
  config.layout = 'application'

  # Proc called with a controller as self. Returns the current user.
  # Default: lambda { current_user }
  config.current_user_proc = -> { current_user }

  # Proc called with a user as argument and a controller as self.
  # This proc is called when a user tries to access the engine's controllers.
  # Should raise an exception, render or redirect unless the user is a manager
  # or admin. The default renders 403 Forbidden for all users.
  # Note: Proc must account for nil users, if current_user_proc returns nil.
  # Default: lambda { |user| head(:forbidden) }
  config.authenticate_admin_proc = ->(user) { head(:forbidden) }

  # Consumer key and secret for connecting to the Salesforce app
  config.salesforce_client_key = 'put_real_key_value_here'
  config.salesforce_client_secret = 'put_real_secret_value_here'

  # Uncomment this to override the login site for sandbox instances
  # config.salesforce_login_site = 'https://test.salesforce.com'

  OpenStax::Salesforce.initialize_omniauth_salesforce
end


