Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users

  get 'cancelation' => 'charges#cancelation'

  root 'home#index'
end
