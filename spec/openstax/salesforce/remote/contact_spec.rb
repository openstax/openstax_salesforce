require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Contact do

  let(:contact) { FactoryBot.create :contact }
  it { is_expected.to be_valid }

end
