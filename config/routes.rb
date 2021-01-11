Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, only: [:new, :create, :show, :edit, :update] do
    resources :procedures, only: [:new, :create]
  end
  resources :users, only: :show
end
