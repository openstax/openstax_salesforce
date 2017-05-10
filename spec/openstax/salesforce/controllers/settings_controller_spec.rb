require 'rails_helper'

RSpec.describe OpenStax::Salesforce::SettingsController, type: :controller do

  context 'as admin' do
    before(:each) { mock_admin_user }

    context '#callback' do
      context 'when there is not yet a SF user' do
        it 'adds a user' do
          allow_any_instance_of(described_class)
            .to receive(:env)
            .and_return(omniauth_env_hash)

          expect{post :callback}.to change {OpenStax::Salesforce::User.count}.by(1)
        end
      end

      context 'when there are other SF users' do
        it 'adds a user and removes existing users' do
          other_user_1 = FactoryGirl.create(:user, do_not_destroy_others: true)
          other_user_2 = FactoryGirl.create(:user, do_not_destroy_others: true)

          allow_any_instance_of(described_class)
            .to receive(:env)
            .and_return(omniauth_env_hash)

          expect{post :callback}.to change {OpenStax::Salesforce::User.count}.by(-1)

          expect(OpenStax::Salesforce::User.all.map(&:id)).not_to contain_exactly(other_user_1.id, other_user_2.id)
        end
      end

      context 'when a user with the same uid already exists' do
        it 'reuses that user' do
          a_user_1 = FactoryGirl.create(:user, uid: 'someuid')

          allow_any_instance_of(described_class)
            .to receive(:env)
            .and_return(omniauth_env_hash)

          post :callback

          expect(a_user_1.reload.name).to eq "Bobby Thomas"
        end
      end
    end

    context '#destroy_user' do
      # https://content.pivotal.io/blog/writing-rails-engine-rspec-controller-tests
      # not needed elsewhere since we do other things to make them top-level routes
      routes { OpenStax::Salesforce::Engine.routes }

      it 'destroys users' do
        FactoryGirl.create(:user)
        expect{delete :destroy_user}.to change {OpenStax::Salesforce::User.count}.by(-1)
      end
    end

  end

  context 'as non-admin' do
    routes { OpenStax::Salesforce::Engine.routes }

    it 'has forbidden status' do
      get :show
      expect(response).to have_http_status(:forbidden)
    end
  end

  def omniauth_env_hash
    {
      "omniauth.auth" => Hashie::Mash.new({
        uid: 'someuid',
        info: {
          name: 'Bobby Thomas',
        },
        credentials: {
          token: 'oauth_token',
          refresh_token: 'refresh_token',
          instance_url: 'http://blah.com/'
        }
      })
    }
  end
end
