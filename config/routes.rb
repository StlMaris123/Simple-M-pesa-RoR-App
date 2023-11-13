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

      post 'transfer', to: 'account_transactions#create'
      post 'stk_push', to: 'stk_push_transactions#stk_push'
      post 'stk_query', to: 'stk_push_transactions#stk_query'
      match '/stk_callback', to: 'stk_push_transactions#callback', via: %i[get post]
      post 'reports', to: 'reports#generate_report'
    end
  end 
end
