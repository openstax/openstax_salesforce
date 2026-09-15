# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Student object from Salesforce. Pseudonymous: Name holds the
      # Accounts user's uuid, never their name or email.
      class Student < ActiveForce::SObject
        field :id,                     from: 'Id'
        field :name,                   from: 'Name'
        field :school_id,              from: 'School__c'
        field :initial_book_id,        from: 'Initial_Book__c'
        field :last_osweb_login_date,  from: 'Last_OSweb_Login_Date__c', as: :date

        self.table_name = 'Student__c'
      end
    end
  end
end
