Rails.application.routes.draw do
  devise_for :users
  root to:"users#index"
  resources :users, only: [:index, :show, :edit, :update]

  resources :messages, only: [:index, :create]
  resources :rooms, only: [:create, :show, :index]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
end