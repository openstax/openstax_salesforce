module OpenStax::Salesforce::Remote
  class School < ActiveForce::SObject
    field :name,   from: 'Name'
    field :is_kip, from: 'K_I_P__c', as: :boolean

    self.table_name = 'Account'
  end
end
