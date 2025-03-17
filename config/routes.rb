Rails.application.routes.draw do
  root "places#index"

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  resources :places, only: [:index, :new, :create, :show] do
    resources :entries, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
