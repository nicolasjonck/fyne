Rails.application.routes.draw do
  # get 'swipes/index', to: 'swipes#index'

  # get 'swipes/new', to: 'swipes#new'
  # get 'swipes', to: 'swipes#create'

  devise_for :users

  resources :events

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'profile', to: 'pages#profile'

  resources :swipes, only: [:index, :new, :create]
end
