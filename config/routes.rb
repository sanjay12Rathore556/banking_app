# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :banks
  resources :branchs
  resources :accounts
  resources :atms
  resources :managers
  resources :users
  resources :transactions
end
