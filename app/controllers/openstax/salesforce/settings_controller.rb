module OpenStax::Salesforce
  class SettingsController < OpenStax::Salesforce::ApplicationController
    layout OpenStax::Salesforce.configuration.layout

    def show
    end

    def callback
      OpenStax::Salesforce::User.save_from_omniauth!(env["omniauth.auth"])
      redirect_to root_path
    end

    def destroy_user
      OpenStax::Salesforce::User.destroy_all
      ActiveForce.clear_sfdc_client! # since user is now gone, any client invalid
      redirect_to root_path
    end

  end
end
