module OpenStax::Salesforce::Remote
  class Contact < ActiveForce::SObject
    belongs_to :school, foreign_key: :school_id,
                        model: OpenStax::Salesforce::Remote::School

    field :name,                         from: "Name"
    field :first_name,                   from: "FirstName"
    field :last_name,                    from: "LastName"
    field :email,                        from: "Email"
    field :email_alt,                    from: "Email_alt__c"
    field :faculty_confirmed_date,       from: "Faculty_Confirmed_Date__c", as: :datetime
    field :faculty_verified,             from: "Faculty_Verified__c"
    field :last_modified_at,             from: "LastModifiedDate"
    field :school_id,                    from: "AccountId"
    field :school_type,                  from: "School_Type__c"
    field :send_faculty_verification_to, from: "SendFacultyVerificationTo__c"
    field :all_emails,                   from: "All_Emails__c"
    field :confirmed_emails,             from: "Confirmed_Emails__c"
    field :adoption_status,              from: "Adoption_Status__c"
    field :grant_tutor_access,           from: "Grant_Tutor_Access__c", as: :boolean
    field :b_r_i_marketing,              from: "BRI_Marketing__c", as: :boolean # Bill of Rights Institute (book) marketing
    field :title_1_school,               from: "Title_1_school__c", as: :boolean

    self.table_name = 'Contact'
  end
end
