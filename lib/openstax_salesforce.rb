require "restforce"
require "active_force"
require "omniauth-salesforce"

require "openstax/salesforce/active_force"

require "openstax/salesforce/engine"
require "openstax/salesforce/user_missing"
require "openstax/salesforce/client"

require "openstax/salesforce/remote/term_year"
require "openstax/salesforce/remote/book"
require "openstax/salesforce/remote/school"
require "openstax/salesforce/remote/opportunity"
require "openstax/salesforce/remote/individual_adoption"
require "openstax/salesforce/remote/class_size"
require "openstax/salesforce/remote/os_ancillary"
require "openstax/salesforce/remote/tutor_course"
require "openstax/salesforce/remote/contact"
require "openstax/salesforce/remote/lead"
require "openstax/salesforce/remote/tutor_onboarding_a"
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
      attr_accessor :layout
      attr_accessor :authenticate_admin_proc
      attr_accessor :salesforce_client_key
      attr_accessor :salesforce_client_secret
      attr_writer   :salesforce_login_site
      attr_accessor :sandbox_oauth_token
      attr_accessor :sandbox_refresh_token
      attr_accessor :sandbox_instance_url
      attr_accessor :check_sandbox_instance_url
      attr_accessor :skip_automatic_omniauth_setup
      attr_accessor :page_heading_proc

      def salesforce_login_site
        @salesforce_login_site || "https://login.salesforce.com"
      end

      def salesforce_client_options
        { site: salesforce_login_site }
      end

      def salesforce_login_domain
        Addressable::URI.parse(salesforce_login_site).host
      end
    end

    def self.set_top_level_routes(router)
      router.match '/auth/salesforce/callback',
                   to: 'openstax/salesforce/settings#callback',
                   via: [:get, :post]
    end

    def self.ready_for_api_usage?
      OpenStax::Salesforce::User.any?
    end

  end
end
