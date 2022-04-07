# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # OpenStax Account object from Salesforce
      class OpenStaxAccount < ActiveForce::SObject
        belongs_to :contact, foreign_key: :salesforce_contact_id, model: OpenStax::Salesforce::Remote::Contact
        belongs_to :lead, foreign_key: :salesforce_lead_id, model: OpenStax::Salesforce::Remote::Lead

        field :id, from: 'Id'
        field :account_id, from: 'Account_ID__c'
        field :account_uuid, from: 'Account_UUID__c'
        field :account_role, from: 'Account_Role__c'
        field :faculty_status, from: 'Faculty_Status__c'
        field :salesforce_contact_id, from: 'Contact__c'
        field :salesforce_lead_id, from: 'Lead__c'
        field :signup_date, from: 'Signup_Date__c', as: :datetime
        field :account_environment, from: 'Environment__c'

        self.table_name = 'OpenStax_Account__c'
      end
    end
  end
end
