require 'rails_helper'
require 'openstax/salesforce/spec_helpers'

include OpenStax::Salesforce::SpecHelpers

RSpec.describe OpenStax::Salesforce::SpecHelpers do

  context '#limit_salesforce_queries' do
    it 'limits by one wildcard' do
      limit_salesforce_queries(OpenStax::Salesforce::Remote::Contact, email: "%foo.com")
      expect(OpenStax::Salesforce::Remote::Contact.select(:id).to_s).to eq(
        "SELECT Id FROM Contact WHERE (Email LIKE '%foo.com')"
      )
    end

    it 'limit by multiple wildcards' do
      limit_salesforce_queries(OpenStax::Salesforce::Remote::Contact, email: "%foo.com", first_name: 'JP%')
      expect(OpenStax::Salesforce::Remote::Contact.select(:id).to_s).to eq(
        "SELECT Id FROM Contact WHERE (Email LIKE '%foo.com') AND (FirstName LIKE 'JP%')"
      )
    end

    it 'limits by wildcard and another condition' do
      limit_salesforce_queries(OpenStax::Salesforce::Remote::Contact, email: "%foo.com", first_name: 'Bob')
      expect(OpenStax::Salesforce::Remote::Contact.select(:id).to_s).to eq(
        "SELECT Id FROM Contact WHERE (Email LIKE '%foo.com') AND (FirstName = 'Bob')"
      )
    end
  end

end
