Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis, shallow: true do
    resources :collaborators, only: [:create, :destroy]
  end

  devise_for :users

  get 'cancelation' => 'charges#cancelation'

  root 'home#index'
end
