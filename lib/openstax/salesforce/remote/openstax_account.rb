# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # OpenStax Account object from Salesforce
      class OpenStaxAccount < ActiveForce::SObject
        belongs_to :contact, foreign_key: :contact_id, model: OpenStax::Salesforce::Remote::Contact
        belongs_to :lead, foreign_key: :lead_id, model: OpenStax::Salesforce::Remote::Lead

        field :id, from: 'Id'
        field :account_id, from: 'Accounts_ID__c'
        field :account_uuid, from: 'Accounts_UUID__c'
        field :role, from: 'Account_Role__c'
        field :contact_id, from: 'Contact__c'
        field :lead_id, from: 'Lead__c'
        field :signup_date, from: 'Signup_Date__c', as: :datetime
        field :accounts_environment, from: 'Environment__c'

        self.table_name = 'OpenStax_Account__c'
      end
    end
  end
end
