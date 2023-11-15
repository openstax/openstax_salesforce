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
        field :email_alt,                    from: 'Email_alt__c'
        field :faculty_confirmed_date,       from: 'Faculty_Confirmed_Date__c', as: :datetime
        field :faculty_verified,             from: 'FV_Status__c'
        field :last_modified_at,             from: 'LastModifiedDate'
        field :school_id,                    from: 'AccountId'
        field :school_type,                  from: 'School_Type__c'
        field :send_faculty_verification_to, from: 'SendFacultyVerificationTo__c'
        field :all_emails,                   from: 'All_Emails__c'
        field :adoption_status,              from: 'Adoption_Status__c'
        field :grant_tutor_access,           from: 'Grant_Tutor_Access__c', as: :boolean
        field :title_1_school,               from: 'Title_1_school__c', as: :boolean
        field :accounts_uuid,                from: 'Accounts_UUID__c'
        field :lead_source,                  from: 'LeadSource'
        field :signup_date,                  from: 'Signup_Date__c', as: :datetime
        field :renewal_eligible,             from: 'Renewal_Eligible__c', as: :boolean

        self.table_name = 'Contact'
      end
    end
  end
end
