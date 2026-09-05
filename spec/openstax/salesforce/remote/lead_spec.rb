require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Lead do
  it 'exposes the conversion fields callers follow to the converted Contact' do
    expect(described_class.mappings).to include(
      is_converted: 'IsConverted',
      converted_contact_id: 'ConvertedContactId'
    )
  end

  it 'no longer maps the retired fields' do
    expect(described_class.mappings.values).not_to include(
      'BRI_Marketing__c', 'Title_1_school__c', 'Instant_Conversion__c', 'Subject__c', 'Newsletter__c'
    )
  end
end
