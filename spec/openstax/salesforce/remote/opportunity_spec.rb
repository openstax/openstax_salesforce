require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Opportunity do

  subject(:opportunity) { described_class.new(term_year: '2016 - 17 Fall') }

  it 'returns a TermYear object' do
    expect(opportunity.term_year_object).to be_a OpenStax::Salesforce::Remote::TermYear
  end

end
