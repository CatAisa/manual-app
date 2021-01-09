Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, only: [:new, :create, :show]
  resources :users, only: :show
end
