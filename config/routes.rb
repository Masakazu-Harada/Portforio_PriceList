Rails.application.routes.draw do
  get 'customer_dashboards/index'

  root to: 'dashboards#index'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users
    resources :departments
    resources :customer_users
  end

  shallow do
    resources :products do
      resources :prices
    end
  end

  resources :products, module: :products do
    resources :suppliers, only: %i[index new create] do
      collection do
        post :cost_update
        get :new_cost
        post :create_cost
        get :price_increase_history
      end
    end
  end

  resources :products, module: :products do
    resources :suppliers, only: %i[index new create] do
      collection do
        get :new_cost
        post :create_cost
      end
    end
  end

  resources :suppliers do
    resources :price_increase_records, only: [:index], module: :suppliers
  end
  
  resources :customers
  resources :customer_dashboards, only: [:index]

  namespace :admin do
    resources :customers, only: [:index]
  end
  
  resources :ranks
  resources :price_lists
  resources :departments
end
