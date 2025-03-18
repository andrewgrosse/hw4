Rails.application.routes.draw do
  root "places#index"  # Set homepage to places#index
  
  resources :places do
    resources :entries  # Nested entries under places
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"  
end
