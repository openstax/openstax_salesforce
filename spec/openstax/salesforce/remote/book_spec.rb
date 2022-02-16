require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Remote::Book do

  let(:book) { FactoryBot.create :book }
  it { is_expected.to be_valid }

end
