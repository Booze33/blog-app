Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "users#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy] do
        collection do
          get :index_api, as: 'index', defaults: { format: :json }
        end
      end
      resource :likes, only: [:create, :destroy]
    end
    collection do
      get :index_api, as: 'index', defaults: { format: :json }
    end
  end
end