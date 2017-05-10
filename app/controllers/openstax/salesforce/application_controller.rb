module OpenStax::Salesforce
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_filter do
      OpenStax::Salesforce.configuration.authenticate_admin_proc.call(self)
    end
  end
end
