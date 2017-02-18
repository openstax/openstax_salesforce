Rails.application.routes.draw do
  mount OpenStax::Salesforce::Engine => "/openstax_salesforce"
end
