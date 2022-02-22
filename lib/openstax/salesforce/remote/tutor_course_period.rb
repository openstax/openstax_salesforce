module OpenStax::Salesforce::Remote
  class TutorCoursePeriod < ActiveForce::SObject
    field :num_teachers,              from: 'Active_Teachers__c', as: :int
    field :base_year,                 from: 'Base_Year__c', as: :int
    field :book_name,                 from: 'Book_Name__c'
    field :contact_id,                from: 'Contact__c'
    field :course_code,               from: 'Course_Code__c'
    field :course_name,               from: 'Course_Name__c'
    field :course_start_date,         from: 'Course_Start_Date__c', as: :date
    field :created_at,                from: 'E_Created_Date__c', as: :datetime
    field :teacher_email,             from: 'Email__c'
    field :error,                     from: 'Error__c'
    field :estimated_enrollment,      from: 'Estimated_Enrollment__c', as: :int
    field :course_id,                 from: 'External_ID__c'
    field :course_uuid,               from: 'External_UUID__c'
    field :latest_adoption_decision,  from: 'Latest_Adoption_Decision__c'
    field :does_cost,                 from: 'Paid_Course__c', as: :boolean
    field :is_research,               from: 'Research_Project__c', as: :boolean
    field :num_periods,               from: 'Sections__c', as: :int
    field :status,                    from: 'Status__c', as: :picklist
    field :num_students_comped,       from: 'Students_Comped__c', as: :int
    field :num_students_dropped,      from: 'Students_Dropped__c', as: :int
    field :num_students_paid,         from: 'Students_Paid__c', as: :int
    field :num_students_refunded,     from: 'Students_Refunded__c', as: :int
    field :num_students,              from: 'Students_Using__c', as: :int
    field :num_students_with_work,    from: 'Students_With_Work__c', as: :int
    field :period_uuid,               from: 'Period_UUID__c'
    field :term,                      from: 'Term__c'
    field :is_pilot,                  from: 'Tutor_Pilot__c', as: :boolean

    self.table_name = 'Tutor_Course__c'

    def reset_stats
      self.num_periods = 0
      self.num_students = 0
      self.num_students_comped = 0
      self.num_students_dropped = 0
      self.num_students_paid = 0
      self.num_students_refunded = 0
      self.num_students_with_work = 0
      self.num_teachers = 0
    end

    STATUS_APPROVED = 'Approved'.freeze
    STATUS_ARCHIVED = 'ArchivedPeriod'.freeze
    STATUS_DROPPED  = 'Dropped'.freeze
    STATUS_PREVIEW = 'Preview'.freeze
  end
end
