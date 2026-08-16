require 'rails_helper'

RSpec.describe OpenStax::Salesforce::Client do
  let(:configuration) { OpenStax::Salesforce.configuration }

  around do |example|
    original = configuration.dup
    example.run
    OpenStax::Salesforce.instance_variable_set(:@configuration, original)
  end

  before do
    configuration.consumer_key = 'consumer_key'
    configuration.consumer_secret = 'consumer_secret'
    configuration.login_domain = 'openstax.my.salesforce.com'
  end

  context "without a username" do
    before { configuration.username = nil }

    it "uses the client credentials flow" do
      expect(described_class.new.authentication_middleware).to eq(
        Restforce::Middleware::Authentication::ClientCredential
      )
    end

    it "rejects a generic login domain" do
      configuration.login_domain = 'test.salesforce.com'

      expect { described_class.new }.to raise_error(IllegalState, /My Domain/)
    end
  end

  context "with a username" do
    before do
      configuration.username = 'user@example.com'
      configuration.password = 'password'
      configuration.security_token = 'security_token'
    end

    it "still uses the username-password flow" do
      expect(described_class.new.authentication_middleware).to eq(
        Restforce::Middleware::Authentication::Password
      )
    end

    it "requires the security token" do
      configuration.security_token = nil

      expect { described_class.new }.to raise_error(IllegalState, /security token/)
    end
  end
end
