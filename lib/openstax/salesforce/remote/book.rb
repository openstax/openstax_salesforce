# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Book object from Salesforce
      class Book < ActiveForce::SObject
        field :id, from: 'Id'
        field :name, from: 'Name'
        field :official_name, from: 'Official_Name__c'
        field :annualization_number, from: 'Annualization_number__c', as: :decimal

        self.table_name = 'Book__c'

        def self.query
          super.where('Active__c = True AND Official_Name__c != NULL')
        end
      end
    end
  end
end
