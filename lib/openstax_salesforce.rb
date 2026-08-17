require "restforce"
require "active_force"

require "openstax/salesforce/active_force"

require "openstax/salesforce/engine"
require "openstax/salesforce/client"

require "openstax/salesforce/remote/term_year"
require "openstax/salesforce/remote/record_type"
require "openstax/salesforce/remote/book"
require "openstax/salesforce/remote/school"
require "openstax/salesforce/remote/opportunity"
require "openstax/salesforce/remote/tutor_course_period"
require "openstax/salesforce/remote/contact"
require "openstax/salesforce/remote/lead"
require "openstax/salesforce/remote/campaign"
require "openstax/salesforce/remote/campaign_member"
require "openstax/salesforce/remote/account_contact_relation"
require "openstax/salesforce/remote/openstax_account"

# openstax_utilities defines this too, but this gem doesn't depend on it
class IllegalState < StandardError; end unless defined?(IllegalState)

module OpenStax
  module Salesforce
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    # See `config/initializers/openstax_salesforce.rb` for documentation on options
    class Configuration
      # Salesforce rejects client credentials token requests sent to these
      GENERIC_LOGIN_DOMAINS = %w[login.salesforce.com test.salesforce.com].freeze

      attr_writer :api_version, :login_domain
      attr_accessor :username, :password, :security_token, :consumer_key, :consumer_secret

      def api_version
        @api_version ||= '61.0'
      end

      def login_domain
        @login_domain ||= 'test.salesforce.com'
      end

      # Salesforce retires the OAuth username-password flow in Spring '27, so a
      # username is now optional: leave it unset to use client credentials.
      def username_password_flow?
        !username.nil?
      end

      def validate!
        raise(IllegalState, "The Salesforce consumer key is missing") if consumer_key.nil?
        raise(IllegalState, "The Salesforce consumer secret is missing") if consumer_secret.nil?

        if username_password_flow?
          raise(IllegalState, "The Salesforce password is missing") if password.nil?
          raise(IllegalState, "The Salesforce security token is missing") if security_token.nil?
          return
        end

        # Half-removed credentials would otherwise switch flows silently
        unless password.nil? && security_token.nil?
          raise(
            IllegalState,
            "The Salesforce password and security token only apply to the username-password " \
            "flow. Remove them to use client credentials, or set a username to keep using " \
            "the username-password flow."
          )
        end

        if GENERIC_LOGIN_DOMAINS.include?(login_domain)
          raise(
            IllegalState,
            "The Salesforce client credentials flow requires the org's My Domain as the " \
            "login domain (e.g. myorg.my.salesforce.com), not #{login_domain}"
          )
        end
      end
    end

    module Remote
    end
  end
end
