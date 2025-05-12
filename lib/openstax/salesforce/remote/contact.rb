# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Contact object from Salesforce
      class Contact < ActiveForce::SObject
        belongs_to :school, foreign_key: :school_id,
                            model: OpenStax::Salesforce::Remote::School

        field :id,                           from: 'Id'
        field :name,                         from: 'Name'
        field :first_name,                   from: 'FirstName'
        field :last_name,                    from: 'LastName'
        field :email,                        from: 'Email'
        field :faculty_verified,             from: 'FV_Status__c'
        field :last_modified_at,             from: 'LastModifiedDate'
        field :school_id,                    from: 'AccountId'
        field :school_type,                  from: 'School_Type__c'
        field :all_emails,                   from: 'All_Emails__c'
        field :adoption_status,              from: 'Adoption_Status__c'
        field :accounts_uuid,                from: 'Accounts_UUID__c'
        field :lead_source,                  from: 'LeadSource'
        field :signup_date,                  from: 'Signup_Date__c', as: :datetime
        field :assignable_interest,          from: 'Assignable_Interest__c'
        field :assignable_adoption_date,     from: 'Assignable_Adoption_Date__c', as: :datetime

        self.table_name = 'Contact'
      end
    end
  end
end
