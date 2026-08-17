module OpenStax
  module Salesforce
    # OpenStax Salesforce Client connection for Salesforce, inherits from Restforce Client
    class Client < ::Restforce::Data::Client
      def initialize
        configuration = OpenStax::Salesforce.configuration

        configuration.validate!

        # Restforce picks its auth middleware from whichever options are present, and
        # a username/password pair wins over client credentials.
        legacy_options =
          if configuration.username_password_flow?
            {
              username: configuration.username,
              password: configuration.password,
              security_token: configuration.security_token
            }
          else
            {}
          end

        super(
          client_id: configuration.consumer_key,
          client_secret: configuration.consumer_secret,
          api_version: configuration.api_version,
          host: configuration.login_domain,
          **legacy_options
        )
      end
    end
  end
end
