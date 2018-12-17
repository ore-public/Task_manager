Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, :except => [:index]
  resources :users, only: [:new, :create, :show]
end
