module OpenStax::Salesforce::Remote
  class Campaign < ActiveForce::SObject

    field :is_active,                   from: "IsActive",              as: :boolean
    field :name,                        from: "Name"

    self.table_name = 'Campaign'

  end
end
