Rails.application.routes.draw do
  get '/foods', to: 'foods#index'
end
