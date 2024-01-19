# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # School object from Salesforce
      class School < ActiveForce::SObject
        field :id,                      from: 'Id'
        field :name,                    from: 'Name'
        field :city,                    from: 'BillingCity'
        field :state,                   from: 'BillingState'
        field :country,                 from: 'BillingCountry'
        field :type,                    from: 'Type'
        field :school_location,         from: 'School_Location__c'
        field :sheerid_school_name,     from: 'SheerID_School_Name__c'
        field :is_kip,                  from: 'K_I_P__c',        as: :boolean
        field :is_child_of_kip,         from: 'child_of_kip__c', as: :boolean
        field :total_school_enrollment, from: 'Total_School_Enrollment__c', as: :integer

        self.table_name = 'Account'

        def self.query
          super.where("RecordType.Name = 'School' OR RecordType.Name = 'School District' OR RecordType.Name = 'General'")
        end
      end
    end
  end
end
