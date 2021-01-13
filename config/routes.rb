Rails.application.routes.draw do
  devise_for :users
  root to: "manuals#index"
  resources :manuals, except: :index do
    resources :procedures, except: [:index, :show]
  end
  resources :users, only: :show
end
