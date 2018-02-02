Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  root "home#index"
end
