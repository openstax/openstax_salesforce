# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Lead object from Salesforce
      class Lead < ActiveForce::SObject

        VALID_VERIFICATION_STATUSES = %w[
          pending_faculty
          confirmed_faculty
          rejected_faculty
        ].freeze

        VALID_WHO_CHOOSES_BOOKS = %w[instructor committee coordinator].freeze

        field :id,                  from: 'Id'
        field :name,                from: 'Name'
        field :first_name,          from: 'FirstName'
        field :last_name,           from: 'LastName'
        field :salutation,          from: 'Salutation'
        field :title,               from: 'Title'
        field :subject,             from: 'Subject__c'
        field :school,              from: 'Company'
        field :city,                from: 'City'
        field :state,               from: 'State'
        field :state_code,          from: 'StateCode'
        field :country,             from: 'Country'
        field :phone,               from: 'Phone'
        field :website,             from: 'Website'
        field :status,              from: 'Status'
        field :email,               from: 'Email'
        field :source,              from: 'LeadSource'
        field :newsletter,          from: 'Newsletter__c'
        field :newsletter_opt_in,   from: 'Newsletter_Opt_In__c'
        field :adoption_status,     from: 'Adoption_Status__c'
        field :adoption_json,       from: 'AdoptionsJSON__c'
        field :num_students,        from: 'Number_of_Students__c'
        field :os_accounts_id,      from: 'Accounts_ID__c'
        field :accounts_uuid,       from: 'Accounts_UUID__c'
        field :application_source,  from: 'Application_Source__c'
        field :role,                from: 'Role__c'
        field :position,            from: 'Position__c'
        field :who_chooses_books,   from: 'who_chooses_books__c'
        field :verification_status, from: 'FV_Status__c'
        field :b_r_i_marketing,     from: 'BRI_Marketing__c', as: :boolean # Bill of Rights Institute (book) marketing
        field :title_1_school,      from: 'Title_1_school__c', as: :boolean
        field :sheerid_school_name, from: 'SheerID_School_Name__c'
        field :instant_conversion,  from: 'Instant_Conversion__c', as: :boolean

        # These 2 fields both hold the Account (School) ID, but have different data types and uses in SF
        field :account_id,          from: 'Account_ID__c'
        field :school_id,           from: 'School__c'

        validates(:last_name, presence: true)
        validates(:school, presence: true)
        validates(
          :verification_status,
          allow_blank: true,
          inclusion: {
            in: VALID_VERIFICATION_STATUSES,
            message: "must be either #{VALID_VERIFICATION_STATUSES.join(' or ')}"
          }
        )

        validates(
          :who_chooses_books,
          allow_blank: true,
          inclusion: {
            in: VALID_WHO_CHOOSES_BOOKS,
            message: "must be either #{VALID_WHO_CHOOSES_BOOKS.join(' or ')}"
          }
        )

        self.table_name = 'Lead'

      end
    end
  end
end
