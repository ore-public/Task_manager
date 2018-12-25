Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, :except => [:index]
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :task_label_relations, only: [:destroy]
end
