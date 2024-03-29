Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'sessions/new'
  get 'users/new'
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  # Define the parent route.
  resources :home, only: [:show]
  resources :users
  resources :account_activations, only: [:edit]
  resources :bookings, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  get 'hotel_listings_manager',  to: "hotel_listings_manager#index"
  namespace :hotel_listings_manager do
    resources :bookings, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :room_amenities, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :location_photos, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :amenities, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :user_reservations, only: [:index]
    resources :photos, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :room_numbers, only: [:index]
    resources :rooms, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :manage_room_numbers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
    resources :beds, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :categories, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :locations, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :bookings, only: [:index]
    resources :users, only: [:index, :destroy]
  end
  get 'rooms/:room_id/manage_room_number', to: 'rooms#manage_room_number', as: :manage_room_number
  resources :rooms, only: [:index] do
    resources :room_details, only: [:index]
  end
  resources :locations, only: [:index]
end
