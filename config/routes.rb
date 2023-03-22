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

  resources :products, module: :products do
    resources :suppliers, only: %i[new create]
  end

  resources :suppliers

  resources :ranks
end
