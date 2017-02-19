Rails.application.config.middleware.use OmniAuth::Builder do
  unless OpenStax::Salesforce.configuration.skip_automatic_omniauth_setup
    provider :salesforce,
             OpenStax::Salesforce.configuration.salesforce_client_key,
             OpenStax::Salesforce.configuration.salesforce_client_secret,
             client_options: OpenStax::Salesforce.configuration.salesforce_client_options
  end
end
