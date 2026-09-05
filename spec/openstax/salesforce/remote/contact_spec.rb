require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Contact do
  it 'builds from the factory' do
    expect(FactoryBot.build(:contact)).to be_a(described_class)
  end

  it 'maps the signup-profile fields under the same names Lead uses' do
    shared = %i[phone title role position who_chooses_books subject_interest
                expected_start_semester adoption_json num_students os_accounts_id
                tracking_parameters newsletter_opt_in]
    lead = OpenStax::Salesforce::Remote::Lead.mappings
    shared.each do |attr|
      expect(described_class.mappings[attr]).to eq(lead[attr]), "#{attr} differs from Lead"
    end
  end

  it 'does not map the retiring Newsletter_Opt_Out__c' do
    expect(described_class.mappings.values).not_to include('Newsletter_Opt_Out__c')
  end
end
