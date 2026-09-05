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
        field :phone,                        from: 'Phone'
        field :title,                        from: 'Title'
        field :role,                         from: 'Role__c'
        field :position,                     from: 'Position__c'
        field :who_chooses_books,            from: 'who_chooses_books__c'
        field :subject_interest,             from: 'Subject_Interest__c'
        field :expected_start_semester,      from: 'Expected_Start_Semester__c'
        field :adoption_json,                from: 'AdoptionsJSON__c'
        field :num_students,                 from: 'Number_of_Students__c'
        field :os_accounts_id,               from: 'Accounts_ID__c'
        field :tracking_parameters,          from: 'Tracking_Parameters__c'
        field :newsletter_opt_in,            from: 'Newsletter_Opt_In__c', as: :boolean

        self.table_name = 'Contact'
      end
    end
  end
end
