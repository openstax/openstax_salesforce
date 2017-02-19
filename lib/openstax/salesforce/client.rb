module OpenStax::Salesforce
  class Client < ::Restforce::Data::Client

    def initialize
      user = User.first

      raise(UserMissing, "The Salesforce client was requested but no user is available.") if user.nil?

      client_key = OpenStax::Salesforce.configuration.salesforce_client_key
      client_secret = OpenStax::Salesforce.configuration.salesforce_client_secret

      raise(IllegalState, "The Salesforce key is missing") if client_key.nil?
      raise(IllegalState, "The Salesforce secret is missing") if client_secret.nil?

      super(oauth_token: user.oauth_token,
            refresh_token: user.refresh_token,
            instance_url: user.instance_url,
            client_id: client_key,
            client_secret: client_secret,
            api_version: '37.0')
    end

  end
end
