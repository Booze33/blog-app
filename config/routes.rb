Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index], controller: 'users/posts'
  end

  resources :posts, only: [:show]
end
