require "restforce"
require "active_force"

require "openstax/salesforce/active_force"

require "openstax/salesforce/engine"
require "openstax/salesforce/client"

require "openstax/salesforce/remote/term_year"
require "openstax/salesforce/remote/book"
require "openstax/salesforce/remote/school"
require "openstax/salesforce/remote/opportunity"
require "openstax/salesforce/remote/tutor_course_period"
require "openstax/salesforce/remote/contact"
require "openstax/salesforce/remote/lead"
require "openstax/salesforce/remote/campaign"
require "openstax/salesforce/remote/campaign_member"

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
      attr_writer :api_version, :login_domain
      attr_accessor :username, :password, :security_token, :client_key, :client_secret

      def api_version
        @api_version ||= '37.0'
      end

      def login_domain
        @login_domain ||= 'test.salesforce.com'
      end

      def validate!
        raise(IllegalState, "The Salesforce username is missing") if username.nil?
        raise(IllegalState, "The Salesforce password is missing") if password.nil?
        raise(IllegalState, "The Salesforce security token is missing") if security_token.nil?
        raise(IllegalState, "The Salesforce client key is missing") if client_key.nil?
        raise(IllegalState, "The Salesforce client secret is missing") if client_secret.nil?
      end
    end

    module Remote
    end
  end
end
