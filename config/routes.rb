Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  get "/recipes", to: "recipes#index", as: "recipes"
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
  get "/search", to: "pages#search", as: "search"
  get "/recipes/:id", to: "recipes#show", as: "recipe"
  get "/favourites", to: "favourites#index", as: "favourites"
  get "/account", to: "accounts#show"
  get "/category/:category", to: "categories#show", as: "category_show"

  post "/favourites/create", to: "favourites#create", as: "favourite_create"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
