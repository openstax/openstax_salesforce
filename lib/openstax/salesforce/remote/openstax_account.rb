# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # OpenStax Account object from Salesforce
      class OpenStaxAccount < ActiveForce::SObject
        belongs_to :contact, foreign_key: :salesforce_contact_id, model: OpenStax::Salesforce::Remote::Contact
        belongs_to :lead, foreign_key: :salesforce_lead_id, model: OpenStax::Salesforce::Remote::Lead

        VALID_ROLE_NAME = %w[Unknown Instructor Student].freeze
        VALID_ENV_NAME = %w[production staging qa dev local].freeze

        field :id, from: 'Id'
        field :account_id, from: 'Account_ID__c'
        field :account_uuid, from: 'Account_UUID__c'
        field :account_role, from: 'Account_Role__c'
        field :salesforce_contact_id, from: 'Contact__c'
        field :salesforce_lead_id, from: 'Lead__c'
        field :signup_date, from: 'Signup_Date__c', as: :datetime
        field :account_environment, from: 'Environment__c'

        validates(
          :account_role,
          allow_blank: false,
          inclusion: {
            in: VALID_ROLE_NAME,
            message: "must be either #{VALID_ROLE_NAME.join(' or ')}"
          }
        )

        validates(
          :account_environment,
          allow_blank: false,
          inclusion: {
            in: VALID_ENV_NAME,
            message: "must be either #{VALID_ENV_NAME.join(' or ')}"
          }
        )

        self.table_name = 'OpenStax_Account__c'
      end
    end
  end
end
