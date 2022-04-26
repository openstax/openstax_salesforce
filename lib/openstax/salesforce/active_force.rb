# frozen_string_literal: true

# Monkey patching
module ActiveForce
  class << self
    # Use a lazy setting of the client so that migrations etc are in place
    # to allow the Client to be successfully instantiated.
    alias_method :original_sfdc_client, :sfdc_client
    def sfdc_client
      if original_sfdc_client.is_a?(OpenStax::Salesforce::Client)
        self.sfdc_client = OpenStax::Salesforce::Client.new
      elsif original_sfdc_client.is_a?(OpenStax::Salesforce::BulkApi)
        self .sfdc_client = OpenStax::Salesforce::BulkApi.new
      else
        original_sfdc_client
      end
    end

    def clear_sfdc_client!
      self.sfdc_client = nil
    end
  end

  class SObject
    def self.find_or_initialize_by(conditions)
      find_by(conditions) || new(conditions)
    end

    # Save that precious SF API call count!
    def save_if_changed
      save if changed?
    end

    # We sometimes mock `query` in specs, and it is helpful to have
    # access to the original implementation
    singleton_class.send(:alias_method, :original_query, :query)
  end
end
