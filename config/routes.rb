Rails.application.routes.draw do
  # main controller
  root "main#home"

  #users controller
  get  '/signup',  to: 'users#new'
  resources :users

  #sessions controller
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
