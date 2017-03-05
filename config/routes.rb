Rails.application.routes.draw do
  root to: "points#index"

  resources :points, only: [:index, :show, :create, :destroy]
end
