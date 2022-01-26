Rails.application.routes.draw do
  get '/foods', to: 'foods#index'
  resources :categories
  get '/categories', to: 'categories#index'
end
