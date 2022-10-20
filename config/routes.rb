Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users 

  resources :users, only: [:show, :index]
  # resources :user_profiles
  resources :profiles
  resources :likes, only: [:create, :destroy]

  resources :dislikes, only: [:create, :destroy]

  root "articles#index"
  resources :articles do
    resources :comments
  end

end
