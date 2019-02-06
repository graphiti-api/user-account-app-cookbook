Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    get '/users/current', controller: :users, action: :show
    resources :credentials, only: :create
    resources :registrations, only: :create
  end

  get '*path' => 'index#index'
  root to: 'index#index'
end
