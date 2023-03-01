Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :departments
  end
  resources :products
end
