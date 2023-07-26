Rails.application.routes.draw do
  root "users#index"

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resource :likes, only: [:create, :destroy]
    end
  end
end
