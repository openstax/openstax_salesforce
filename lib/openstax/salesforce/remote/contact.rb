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
    field :send_faculty_verification_to, from: "SendFacultyVerificationTo__c"
    field :all_emails,                   from: "All_Emails__c"
    field :confirmed_emails,             from: "Confirmed_Emails__c"

    self.table_name = 'Contact'
  end
end
