Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show]
  resources :posts, only: [:create, :update]

  resources :workouts do
    resources :activities, shallow: true do
      resources :activity_sets, as: "set", path: "sets", shallow: true do
        put :toggle_warmup, on: :member
      end
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "dashboard" => "dashboard#index", as: :dashboard

  # Defines the root path route ("/")
  root "static#homepage"
end
