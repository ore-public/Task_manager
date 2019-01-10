# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, except: [:index]
  namespace :admin do
    resources :users
  end
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  get 'groups/seach', to: 'groups#all'
  resources :groups
end
