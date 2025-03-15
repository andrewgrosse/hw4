Rails.application.routes.draw do
  root "places#index"  # ✅ Home page

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :places, only: [:index, :new, :create, :show]
  resources :entries, only: [:new, :create, :edit, :update, :destroy]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
