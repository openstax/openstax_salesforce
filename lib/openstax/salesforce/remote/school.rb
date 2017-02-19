module OpenStax::Salesforce::Remote
  class School < ActiveForce::SObject
    field :name,                      from: "Name"

    self.table_name = 'Account'
  end
end
