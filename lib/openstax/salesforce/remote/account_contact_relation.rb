# frozen_string_literal: true

module OpenStax
  module Salesforce
    module Remote
      # School/Contact relation object from Salesforce
      class AccountContactRelation < ActiveForce::SObject
        belongs_to :school, foreign_key: :school_id,
                            model: OpenStax::Salesforce::Remote::School

        belongs_to :contact, foreign_key: :contact_id,
                             model: OpenStax::Salesforce::Remote::Contact

        field :contact_id, from: 'ContactId'
        field :primary, from: 'IsDirect', as: :boolean
        field :school_id, from: 'AccountId'

        self.table_name = 'AccountContactRelation'
      end
    end
  end
end
