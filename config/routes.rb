Rails.application.routes.draw do
  get "/", to: "places#index"  # Redirect root to places page

  resources :places, only: [:index, :new, :create, :show]  # Ensure places routes exist
  
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
