Rails.application.routes.draw do
  root to: 'dashboards#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users
    resources :departments
  end

  shallow do
    resources :products do
      resources :prices
    end
  end

  resources :ranks
end
