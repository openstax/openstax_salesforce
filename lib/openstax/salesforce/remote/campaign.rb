# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # Campaign object from Salesforce
      class Campaign < ActiveForce::SObject
        field :is_active,                   from: 'IsActive', as: :boolean
        field :name,                        from: 'Name'

        self.table_name = 'Campaign'
      end
    end
  end
end
