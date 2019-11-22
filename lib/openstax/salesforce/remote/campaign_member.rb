module OpenStax::Salesforce::Remote
  class CampaignMember < ActiveForce::SObject
    field :campaign_id,                                       from: "CampaignId"
    field :contact_id,                                        from: "ContactId"
    field :accounts_uuid,                                     from: "accounts_uuid__c"

    field :pardot_reported_contact_id,                        from: "pardot_reported_contact_id__c"
    field :pardot_reported_piaid,                             from: "pardot_reported_piaid__c"
    field :pardot_reported_picid,                             from: "pardot_reported_picid__c"

    field :first_teacher_contact_id,                          from: "first_teacher_contact_id__c"

    field :arrived_marketing_page_from_pardot_at,             from: "arrived_marketing_page_from_pardot_at__c",    as: :datetime
    field :arrived_marketing_page_not_from_pardot_at,         from: "arrived_marketing_page_not_from_pardot_a__c", as: :datetime
    field :first_arrived_my_courses_at,                       from: "first_arrived_my_courses_at__c",              as: :datetime
    field :preview_created_at,                                from: "preview_created_at__c",                       as: :datetime
    field :real_course_created_at,                            from: "real_course_created_at__c",                   as: :datetime
    field :like_preview_ask_later_count,                      from: "like_preview_ask_later_count__c",             as: :int
    field :like_preview_yes_at,                               from: "like_preview_yes_at__c",                      as: :datetime
    field :latest_adoption_decision,                          from: "latest_adoption_decision__c",                 as: :picklist
    field :latest_adoption_decision_at,                       from: "latest_adoption_decision_at__c",              as: :datetime

    field :estimated_enrollment, from: "Estimated_Enrollment__c", as: :int
    field :ignored_osas, from: "Ignored_OSAs__c", as: :boolean

    field :percent_enrolled, from: "Percent_Enrolled__c", as: :percent
    field :school_type, from: "School_Type__c"
    field :students_registered, from: "Students_Registered__c", as: :int
    field :students_reported_by_teacher, from: "Students_Reported_by_Teacher__c", as: :int
    field :students_with_work, from: "Students_with_work__c", as: :int
    field :sync_field, from: "SyncField__c", as: :datetime

    belongs_to :contact, model: OpenStax::Salesforce::Remote::Contact
    belongs_to :first_teacher_contact, model: OpenStax::Salesforce::Remote::Contact
    belongs_to :pardot_reported_contact, model: OpenStax::Salesforce::Remote::Contact

    self.table_name = 'CampaignMember'
  end
end
