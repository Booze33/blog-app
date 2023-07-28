Rails.application.routes.draw do
  root "users#index"

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
  end
end
