Rails.application.routes.draw do
  root 'static#index'

  get 'signup',    to: 'users#new'
  get 'profile',   to: 'users#profile'
  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]
  resources :events
  resources :invitations
end
