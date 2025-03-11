Rails.application.routes.draw do
  get "/", to: "places#index"

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
