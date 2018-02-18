Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  # authenticated :user do
  #   root 'home#index', as: :authenticated_root
  # end

  # devise_scope :user do
  #   root 'devise/sessions#new'
  # end

  root 'home#index'
end
