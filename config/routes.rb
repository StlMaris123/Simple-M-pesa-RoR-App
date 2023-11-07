# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_for :users, only: []
      post '/auth', to: 'sessions#create'
      resources :users, only: %I[index show create update destroy]
      resources :messages, only: [:create]
    end
  end
end
