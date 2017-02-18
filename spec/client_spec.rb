require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Client do

  it 'raises when there is no SF user' do
    allow(OpenStax::Salesforce::User).to receive(:first) { nil }
    expect{ described_class.new }.to raise_error(OpenStax::Salesforce::UserMissing)
  end

end
