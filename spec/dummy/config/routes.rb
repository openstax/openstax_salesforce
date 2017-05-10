Rails.application.routes.draw do
  mount OpenStax::Salesforce::Engine => "/admin/salesforce"
  OpenStax::Salesforce.set_top_level_routes(self)
end
