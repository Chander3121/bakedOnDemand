Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "welcome#landing_page"

  get "/profile", to: "users#show"

  resource :dashboard, only: [:show], controller: "dashboard" do
    get :profile
    get :orders
    get :addresses
  end

  resources :products
  get "cakes", to: "products#cakes", as: :cakes
  get "pastries", to: "products#pastries", as: :pastries

  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]

  resource :checkout, only: [:new, :create]
  get "/payment", to: "payments#show"
  post "/payment/verify", to: "payments#verify"

  resources :orders do
    member do
      get :success
    end
  end
  get "/track-order", to: "orders#track"
  post "/track-order", to: "orders#find"

  # Admin routes starts here
  namespace :admin do
    get "dashboard/index"
    root "dashboard#index"

    resources :products
    resources :product_variants
    resources :categories
    resources :tags
    resources :orders
  end
end
