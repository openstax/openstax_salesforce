module OpenStax::Salesforce::Remote
  class School < ActiveForce::SObject
    field :name,                from: 'Name'
    field :type,                from: 'Type'
    field :school_location,     from: 'School_Location__c'
    field :sheerid_school_name, from: 'SheedID_School_Name__c'
    field :is_kip,              from: 'K_I_P__c',        as: :boolean
    field :is_child_of_kip,     from: 'child_of_kip__c', as: :boolean

    self.table_name = 'Account'
  end
end
