# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Opportunity object from Salesforce
      class Opportunity < ActiveForce::SObject

        belongs_to :record_type, foreign_key: :record_type_id, model: OpenStax::Salesforce::Remote::RecordType
        belongs_to :book, foreign_key: :book_id, model: OpenStax::Salesforce::Remote::Book
        belongs_to :school, foreign_key: :school_id, model: OpenStax::Salesforce::Remote::School

        VALID_STAGE_NAMES = [
          'Confirmed Adoption Won',
          'Closed Lost'
        ].freeze

        VALID_TYPES = [
          'New Business',
          'Renewal',
          'Renewal - Verified'
        ].freeze

        field :term_year,                    from: 'TermYear__c'
        field :book_name,                    from: 'Book_Text__c'
        field :contact_id,                   from: 'Contact__c'
        field :close_date,                   from: 'CloseDate', as: :datetime
        field :stage_name,                   from: 'StageName'
        field :type,                         from: 'Type'
        field :number_of_students,           from: 'Students__c'
        field :student_number_status,        from: 'Student_No_Status__c'
        field :time_period,                  from: 'Time_Period__c'
        field :class_start_date,             from: 'Class_Start_Date__c',  as: :datetime
        field :renewal_class_start_date,     from: 'CSDInput__c',  as: :datetime
        field :school_id,                    from: 'AccountId'
        field :book_id,                      from: 'Book__c'
        field :contact_id,                   from: 'Contact__c'
        field :os_accounts_id,               from: 'OS_Accounts_ID__c'
        field :accounts_uuid,                from: 'Accounts_UUID__c'
        field :name,                         from: 'Name'
        field :record_type_name,             from: 'Opportunity_Record_Type_Name__c'
        field :record_type_id,               from: 'RecordTypeId'

        validates(
          :stage_name,
          allow_blank: false,
          inclusion: {
            in: VALID_STAGE_NAMES,
            message: "must be either #{VALID_STAGE_NAMES.join(' or ')}"
          }
        )

        validates(
          :type,
          allow_blank: false,
          inclusion: {
            in: VALID_TYPES,
            message: "must be either #{VALID_TYPES.join(' or ')}"
          }
        )

        self.table_name = 'Opportunity'

        def term_year_object
          @term_year_object ||= OpenStax::Salesforce::Remote::TermYear.from_string(term_year)
        end
      end
    end
  end
end
