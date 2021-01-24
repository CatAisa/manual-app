Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, except: :index do
    resources :procedures, except: [:index, :show] do
      resources :comments, only: [:create, :destroy]
    end
    resources :releases, only: [:create, :destroy]
  end
  resources :users, only: :show
end
