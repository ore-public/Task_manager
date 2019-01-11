# frozen_string_literal: true

Rails.application.routes.draw do
  get 'join_groups/new'
  get 'join_groups/create'
  get 'join_groups/destroy'
  root to: 'tasks#index'
  resources :tasks, except: [:index]
  namespace :admin do
    resources :users
  end
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  get 'groups/seach', to: 'groups#all'
  resources :groups
  resources :join_groups, only: %i[new create destroy]
end
