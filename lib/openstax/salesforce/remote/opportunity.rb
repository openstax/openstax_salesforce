module OpenStax::Salesforce::Remote
  class Opportunity < ActiveForce::SObject
    field :term_year,                    from: "TermYear__c"
    field :book_name,                    from: "Book_Text__c"
    field :contact_id,                   from: "Contact__c"
    field :new,                          from: "New__c",       as: :boolean

    self.table_name = 'Opportunity'

    def term_year_object
      @term_year_object ||= OpenStax::Salesforce::Remote::TermYear.from_string(term_year)
    end
  end
end
