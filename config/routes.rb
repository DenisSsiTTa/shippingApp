Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    # registrations: 'users/registrations' # rails g devise:controllers users
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :publications do
    member do
      post "contact_email"
    end
  end

  # Routes

  #get 'pages/account'
  #get 'pages/index'

  resources :pages, only: [:index] do
    collection do
      get 'account'
    end
  end

  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
