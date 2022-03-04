Rails.application.routes.draw do
  root 'foods#index'
  resources :foods
  resources :categories
  get '/categories', to: 'categories#index'
end
