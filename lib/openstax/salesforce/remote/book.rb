# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Book object from Salesforce
      class Book < ActiveForce::SObject
        field :name,                 from: 'Name'
        field :annualization_number, from: 'Annualization_number__c', as: :decimal

        self.table_name = 'Book__c'
      end
    end
  end
end
