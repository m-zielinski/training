Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"

  get "/api_proxy/:id", to: "movies#fetch_additional_data", format: :json

  get :top_commenters, to: 'top_commenters#index'

  mount Commontator::Engine => '/commontator'

  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :movies, only: [:index, :show]
    end
    namespace :v2 do
      resources :movies, only: [:index, :show]
    end
  end
end
