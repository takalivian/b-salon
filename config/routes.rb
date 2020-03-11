Rails.application.routes.draw do
  devise_for :users
  root to:"posts#index"
  resources :users, only: [:index, :show]

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :posts, only: [:index, :new]
end