Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, except: :index do
    resources :procedures, only: [:new, :create]
  end
  resources :users, only: :show
end
