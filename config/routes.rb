Rails.application.routes.draw do
  get 'password_reset/new'
  get 'password_reset/edit'
  root 'home#index'
  get 'about', to: 'home#about'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'passwords/reset', to: 'passwords_reset#new'
  post 'passwords/reset', to: 'passwords_reset#create'
  get 'passwords/reset/edit', to: 'passwords_reset#edit'
  patch 'passwords/reset/edit', to: 'passwords_reset#update'

  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  delete 'registration/destroy', to: 'registrations#destroy'
end
