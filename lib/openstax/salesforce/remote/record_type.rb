module OpenStax::Salesforce::Remote
  class RecordType < ActiveForce::SObject
    field :id,                      from: 'Id'
    field :name,                    from: 'Name'
    field :salesforce_object_name,  from: 'SobjectType'

    self.table_name = 'RecordType'

    def self.query
      super.where('IsActive = true')
    end
  end
end
