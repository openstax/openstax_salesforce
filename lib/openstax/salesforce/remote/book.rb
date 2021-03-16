module OpenStax::Salesforce::Remote
  class Book < ActiveForce::SObject
    field :name,                 from: "Name"
    field :annualization_number, from: "Annualization_number__c", as: :decimal

    self.table_name = 'Book__c'
  end
end
