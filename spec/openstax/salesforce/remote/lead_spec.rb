require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Lead do
  it 'exposes the conversion fields callers follow to the converted Contact' do
    expect(described_class.mappings).to include(
      is_converted: 'IsConverted',
      converted_contact_id: 'ConvertedContactId'
    )
  end

  it 'maps the login date under the same attribute name Contact and Student use' do
    expect(described_class.mappings).to include(last_account_login_date: 'Last_Account_Login_Date__c')
    expect(OpenStax::Salesforce::Remote::Contact.mappings).to include(last_account_login_date: 'Last_Account_Login_Date__c')
  end

  it 'no longer maps the retired fields' do
    expect(described_class.mappings.values).not_to include(
      'BRI_Marketing__c', 'Title_1_school__c', 'Instant_Conversion__c', 'Subject__c', 'Newsletter__c'
    )
  end
end
