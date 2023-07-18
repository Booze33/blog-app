Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index], controller: 'users/posts'
  end
  resources :posts, only: [:show], controller: 'posts'
  # Defines the root path route ("/")
  # root "articles#index"
end
