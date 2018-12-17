Rails.application.routes.draw do
  get 'sessions/new'
  root to: "tasks#index"
  resources :tasks, :except => [:index]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
