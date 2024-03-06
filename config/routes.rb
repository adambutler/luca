Rails.application.routes.draw do
  mount Lookbook::Engine, at: "/lookbook"

  devise_for :users

  resources :users, only: [:show] do
    resources :exercises, only: [:new, :create], controller: "user/exercises"
  end

  resources :posts, only: [:create, :update]

  resources :workouts do
    resources :activities, shallow: true do
      post :search, on: :collection

      resources :activity_sets, as: "set", path: "sets", shallow: true do
        put :copy_load_from_goal, on: :member
        put :copy_repetitions_from_goal, on: :member
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
