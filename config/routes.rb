Rails.application.routes.draw do
  get 'home/index'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users

  root 'home#index'
end
