require "restforce"
require "active_force"
require "omniauth-salesforce"

require "openstax/salesforce/engine"
require "openstax/salesforce/user_missing"
require "openstax/salesforce/client"
require "openstax/salesforce/remote/contact"
require "openstax/salesforce/remote/lead"


module OpenStax
  module Salesforce

    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    ###########################################################################
    #
    # Configuration machinery.
    #
    # To configure OpenStax Salesforce, put the following code in your applications
    # initialization logic (eg. in the config/initializers in a Rails app)
    #
    #   OpenStax::Salesforce.configure do |config|
    #     config.<parameter name> = <parameter value>
    #     ...
    #   end
    #
    class Configuration
      # The view layout used (default: 'application')
      attr_accessor :layout

      # Proc that returns the current user
      attr_accessor :current_user_proc

      # This proc is passed the current user and must return `true` if an only if
      # the user is an admin user (or otherwise has permission to use this engine's
      # admin-level tools)
      attr_accessor :authenticate_admin_proc

      # The key and secret for connecting to an app on the production salesforce instance
      attr_accessor :salesforce_client_key
      attr_accessor :salesforce_client_secret

      # A param for overriding the default Salesforce login site (e.g. for sandbox login)
      attr_accessor :salesforce_login_site

      # The following sandbox tokens are used for specs to connect to a sandbox Salesforce
      # instance.
      attr_accessor :sandbox_oauth_token
      attr_accessor :sandbox_refresh_token
      attr_accessor :sandbox_instance_url

      # If `check_sandbox_instance_url` is true (which is the default), the spec helper
      # that uses the instance URL will checks that the URL starts with "cs", which
      # indicates that the instance is a sandbox.
      attr_accessor :check_sandbox_instance_url

      def initialize
        @layout = 'application'
        @authenticate_admin_proc = ->(user) { head(:forbidden) }
        @current_user_proc = -> { nil }
        @check_sandbox_instance_url = true
        @salesforce_login_site = nil
      end

      def salesforce_client_options
        salesforce_login_site ? { site: salesforce_login_site } : {}
      end
    end

    # Call this in your initializers after setting values for salesforce key and secret
    def self.initialize_omniauth_salesforce
      Rails.application.config.middleware.use OmniAuth::Builder do
        provider :salesforce,
                 OpenStax::Salesforce.configuration.salesforce_client_key,
                 OpenStax::Salesforce.configuration.salesforce_client_secret,
                 client_options: OpenStax::Salesforce.configuration.salesforce_client_options
      end
    end

    def self.set_top_level_routes(router)
      router.match '/auth/salesforce/callback',
                   to: 'openstax/salesforce/settings#callback',
                   via: [:get, :post]
    end

  end
end

# Monkey patching

module ActiveForce

  class << self

    # Use a lazy setting of the client so that migrations etc are in place
    # to allow the Client to be successfully instantiated.
    alias_method :original_sfdc_client, :sfdc_client
    def sfdc_client
      if !original_sfdc_client.is_a?(OpenStax::Salesforce::Client)
        self.sfdc_client = OpenStax::Salesforce::Client.new
      end
      original_sfdc_client
    end

    def clear_sfdc_client!
      self.sfdc_client = nil
    end
  end

  class SObject
    # Save that precious SF API call count!
    def save_if_changed
      save if changed?
    end
  end

end
