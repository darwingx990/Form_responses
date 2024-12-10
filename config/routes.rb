Rails.application.routes.draw do
  resources :responses
  resources :forms
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    # get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/*
    resources :forms, only: [:index, :new, :create, :show]
    
    # Defines the root path route ("/")
    root "forms#index"

    # get '/assets/stylesheets/application.tailwind.css', to: sprockets.asset_path

    resources :responses, only: [:new, :create]
    # root 'responses#new'
end

