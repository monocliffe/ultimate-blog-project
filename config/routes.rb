Rails.application.routes.draw do
  root 'home#index'

  resources :users

  get 'signup', to: 'users#new', as: 'signup'
  get 'home', to: 'home#index', as: 'home'
end
