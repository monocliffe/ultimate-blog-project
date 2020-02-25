Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :posts do
    member do
      get 'restore'
    end
  end
  resource :session

  get 'signup', to: 'users#new', as: 'signup'
  get 'home', to: 'home#index', as: 'home'
  get 'login', to: 'sessions#new', as: 'login'
end
