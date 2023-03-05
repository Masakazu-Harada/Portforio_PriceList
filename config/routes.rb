Rails.application.routes.draw do
  get 'dashboards/index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users
    resources :departments
  end
  resources :products
end
