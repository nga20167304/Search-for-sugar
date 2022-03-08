Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'foods#index'
  resources :foods
  resources :categories
  get '/categories', to: 'categories#index'
end
