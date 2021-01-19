Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, except: :index do
    resources :procedures, except: [:index, :show] do
      resources :comments, only: :create
    end
  end
  resources :users, only: :show
end
