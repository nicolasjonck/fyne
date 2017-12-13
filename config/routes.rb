Rails.application.routes.draw do
  get 'swipes/index'

  devise_for :users

  resources :events

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'profile', to: 'pages#profile'
end
