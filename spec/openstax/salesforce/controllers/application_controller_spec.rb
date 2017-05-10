require 'rails_helper'

RSpec.describe OpenStax::Salesforce::ApplicationController, type: :controller do

  controller do
    def index
      render :text => "Yo"
    end
  end

  it 'has forbidden status by default' do
    get :index
    expect(response).to have_http_status(:forbidden)
  end

  it 'can have its admin check overridden' do
    mock_admin_user
    get :index
    expect(response).to have_http_status(:success)
  end

end
