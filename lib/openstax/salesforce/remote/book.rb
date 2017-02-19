module OpenStax::Salesforce::Remote
  class Book < ActiveForce::SObject
    field :name,                      from: "Name"

    self.table_name = 'Book__c'
  end
end
