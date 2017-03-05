Rails.application.routes.draw do
  root to: "points#index"

  resources :points, only: [:index, :show, :create, :destroy] do
    member do
      get 'find_nearest_points'
    end
  end
end
