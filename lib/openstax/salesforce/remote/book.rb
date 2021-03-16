module OpenStax::Salesforce::Remote
  class Book < ActiveForce::SObject
    field :name,                 from: "Name"
    field :annualization_number, from: "Annualization_number__c"

    self.table_name = 'Book__c'
  end
end
