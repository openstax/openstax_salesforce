module OpenStax::Salesforce
  class Client < ::Restforce::Data::Client
    def initialize
      configuration = OpenStax::Salesforce.configuration

      configuration.validate!

      super(
        username:       configuration.username,
        password:       configuration.password,
        security_token: configuration.security_token,
        client_id:      configuration.client_key,
        client_secret:  configuration.client_secret,
        api_version:    configuration.api_version,
        host:           configuration.login_domain
      )
    end
  end
end
