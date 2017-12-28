module OpenStax::Salesforce::Remote
  class OsAncillary < ActiveForce::SObject

    field :status,                    from: "Status__c", as: :picklist
    field :product,                   from: "Product__c", as: :picklist
    field :account_type,              from: "Account_Type__c"
    field :book_name,                 from: "Book_Name__c"
    field :course_start_date,         from: "Course_Start_Date__c", as: :date
    field :course_name,               from: "Course_Name__c"
    field :course_code,               from: "Course_Code__c"
    field :course_id,                 from: "External_ID__c"
    field :course_uuid,               from: "External_UUID__c"
    field :created_at,                from: "E_Created_Date__c", as: :datetime
    field :error,                     from: "Error__c"
    field :general_access_url,        from: "General_Access_URL__c"
    field :teacher_join_url,          from: "Teacher_Join_URL__c"
    field :school,                    from: "School_Name__c"
    field :num_teachers,              from: "Active_Teachers__c", as: :int
    field :num_sections,              from: "Sections__c", as: :int
    field :num_students,              from: "Students_Using__c", as: :int
    field :num_students_paid,         from: "Students_Paid__c", as: :int
    field :num_students_comped,       from: "Students_Comped__c", as: :int
    field :num_students_refunded,     from: "Students_Refunded__c", as: :int
    field :num_students_dropped,      from: "Students_Dropped__c", as: :int
    field :num_students_with_work,    from: "Students_With_Work__c", as: :int
    field :term_year,                 from: "TermYear__c"
    field :term,                      from: "Term__c"
    field :base_year,                 from: "Manual_Base_Year__c", as: :int
    field :estimated_enrollment,      from: "Estimated_Enrollment__c", as: :int
    field :does_cost,                 from: "Paid_Course__c", as: :boolean
    field :opportunity_id,            from: 'Opportunity__c'
    field :individual_adoption_id,    from: "Individual_Adoption__c"
    field :contact_id,                from: "Contact__c"
    field :campaign_member_id,        from: "Campaign_Member_ID__c"
    field :latest_adoption_decision,  from: "latest_adoption_decision__c"

    belongs_to :opportunity, model: OpenStax::Salesforce::Remote::Opportunity

    self.table_name = 'OS_Ancillary__c'

    def reset_stats
      self.num_students = 0
      self.num_students_paid = 0
      self.num_students_comped = 0
      self.num_students_refunded = 0
      self.num_students_dropped = 0
      self.num_students_with_work = 0
      self.num_teachers = 0
      self.num_sections = 0
    end

    def is_concept_coach?
      "Concept Coach" == product
    end

    def is_tutor?
      "Tutor" == product
    end

    def valid_product?
      ["Tutor", "Concept Coach"].include?(product)
    end

    def term_year_object
      @term_year_object ||= OpenStax::Salesforce::Remote::TermYear.from_string(self.term_year)
    end

    def is_college?
      # Seems like college account types are more likely to be added to
      # more than high school types, so match non college types and negate
      !NON_COLLEGE_ACCOUNT_TYPES.include?(account_type)
    end

    # TODO warn somewhere if come across unknown account type
    def known_account_type?
      ACCOUNT_TYPES.include(account_type)
    end

    NON_COLLEGE_ACCOUNT_TYPES = [
      "High School",
      "Elementary School",
      "Middle/Junior High School",
      "K-12 School"
    ]

    # Unused, here for posterity
    COLLEGE_ACCOUNT_TYPES = [
      "College/University (4)",
      "Technical/Community College (2)",
      "Career School/For-Profit (2)",
      "For-Profit Tutoring",
    ]

    ACCOUNT_TYPES = [
      COLLEGE_ACCOUNT_TYPES,
      NON_COLLEGE_ACCOUNT_TYPES,
      "Other"
    ].flatten

    STATUS_APPROVED = "Approved"

  end
end
