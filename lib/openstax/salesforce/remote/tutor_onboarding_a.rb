module OpenStax::Salesforce::Remote
  class TutorOnboardingA < ActiveForce::SObject

    field :accounts_uuid,                                     from: "accounts_uuid__c"

    field :contact_id,                                        from: "Contact__c"

    field :pardot_reported_contact_id,                        from: "pardot_reported_contact_id__c"
    field :pardot_reported_piaid,                             from: "pardot_reported_piaid__c"
    field :pardot_reported_picid,                             from: "pardot_reported_picid__c"

    field :first_teacher_contact_id,                          from: "first_teacher_contact_id__c"

    field :arrived_marketing_page_from_pardot_at,             from: "arrived_marketing_page_from_pardot_at__c",    as: :datetime
    field :days_since_arrived_marketing_page_from_pardot,     from: "days_since_arrived_marketing_page_from_p__c", as: :double
    field :arrived_marketing_page_not_from_pardot_at,         from: "arrived_marketing_page_not_from_pardot_a__c", as: :datetime
    field :days_since_arrived_marketing_page_not_from_pardot, from: "days_since_arrived_marketing_page_from_p__c", as: :double
    field :preview_created_at,                                from: "preview_created_at__c",                       as: :datetime
    field :real_course_created_at,                            from: "real_course_created_at__c",                   as: :datetime
    field :like_preview_ask_later_count,                      from: "like_preview_ask_later_count__c",             as: :int
    field :like_preview_yes_at,                               from: "like_preview_yes_at__c",                      as: :datetime
    field :days_since_like_preview_yes,                       from: "days_since_like_preview_yes__c",              as: :double
    field :latest_adoption_decision,                          from: "latest_adoption_decision__c",                 as: :picklist
    field :latest_adoption_decision_at,                       from: "latest_adoption_decision_at__c",              as: :datetime

    belongs_to :contact, model: OpenStax::Salesforce::Remote::Contact
    belongs_to :first_teacher_contact, model: OpenStax::Salesforce::Remote::Contact
    belongs_to :pardot_reported_contact, model: OpenStax::Salesforce::Remote::Contact

    self.table_name = 'TutorOnboardingA__c'

  end
end
