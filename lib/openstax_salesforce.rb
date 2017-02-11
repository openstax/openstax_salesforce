require "openstax/salesforce/engine"

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
      # attr_accessor :user_class_name
      # attr_accessor :current_user_method
      # attr_accessor :routing_error_app
      # attr_accessor :validate_cors_origin

      def initialize
        # @user_class_name = 'User'
        # @current_user_method = 'current_user'
        # @routing_error_app = lambda { |env|
        #   [404, {"Content-Type" => 'application/json'}, ['']] }
      end
    end

  end
end
