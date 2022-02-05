Rails.application.routes.draw do
  get '/foods', to: 'foods#index'
  root 'foods#index'
  resources :foods
  resources :categories
  get '/categories', to: 'categories#index'
end
