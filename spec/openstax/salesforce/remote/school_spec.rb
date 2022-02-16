require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::School do

  let(:school) { FactoryBot.create :school }
  it { is_expected.to be_valid }

end
