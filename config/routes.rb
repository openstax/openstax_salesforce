OpenStax::Salesforce::Engine.routes.draw do
  root to: 'settings#show'

  resource :settings, only: [:show] do
    collection do
      delete :destroy_user
    end
  end


end
