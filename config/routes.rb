Rails.application.routes.draw do
  root to: 'dashboards#index'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :users
    resources :departments
    resources :customer_users
    resources :customers, only: [:index]
  end

  resources :products do
    resources :prices, only: [:new, :create, :edit, :update] do
      collection do
        get :bulk_edit
        patch :bulk_update
      end
    end

    resources :product_suppliers do
      resources :cost_increase_histories, path: 'cost', as: 'cost', only: [:new, :create, :edit, :update]
    end

    resources :suppliers, module: :products, only: %i[index new create] do
      collection do
        post :cost_update
        get :new_cost
        post :create_cost
        get :cost_increase_history
      end
    end
  end
  
  resources :prices, only: [:index]
  
  resources :customers
  resources :customer_dashboards, only: [:index]
  resources :ranks
  resources :price_lists
  resources :departments
end
