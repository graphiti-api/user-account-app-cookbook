Rails.application.routes.draw do
  resources :account_activations, only: :show do
    collection do
      # we need to capture the /account_activations/:token route, but
      # fall back to the Vue SPA for the success and error paths.
      get :success, to: 'index#index'
      get :error, to: 'index#index'
    end
  end

  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    get '/users/current', controller: :users, action: :show
    resources :credentials, only: :create
    resources :registrations, only: :create
  end

  get '*path' => 'index#index'
  root to: 'index#index'
end
