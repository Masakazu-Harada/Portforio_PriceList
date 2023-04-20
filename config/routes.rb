Rails.application.routes.draw do
  get 'customer_dashboards/index'
  get 'cusomerdashboards/index'

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
    resources :suppliers, only: %i[index new create] do
      collection do
        post :cost_update
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

  resources :suppliers
  resources :customers
  resources :customer_dashboards, only: [:index]

  namespace :admin do
    resources :customers, only: [:index]
  end
  
  resources :ranks

  resources :price_lists
end
