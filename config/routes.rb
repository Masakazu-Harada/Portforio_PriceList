Rails.application.routes.draw do
  namespace :admin do
    get 'departments/index'
    get 'departments/show'
    get 'departments/new'
    get 'departments/edit'
    resources :users
    resources :departments
  end
  resources :products
end
