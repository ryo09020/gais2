Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resource :users, only: [:show]

  delete "chats/destroy_all/:id" => "chats#destroy_all"
  resources :chats, only: [:create]

  delete "conversations/destroy_all" => "conversations#destroy_all"
  resources :conversations, only: [:create, :destroy, :show]


end
