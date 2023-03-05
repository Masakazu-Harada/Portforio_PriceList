Rails.application.routes.draw do
  root to: 'sessions#new'
  namespace :admin do
    resources :users
    resources :departments
  end
  resources :products
end
