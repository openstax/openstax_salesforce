require "rails_helper"

RSpec.describe 'Engine routes', type: :routing do
  describe "/auth/salesforce/callback" do
    it "routes to #callback" do
      expect(get '/auth/salesforce/callback').to route_to('openstax/salesforce/settings#callback')
    end
  end
end
