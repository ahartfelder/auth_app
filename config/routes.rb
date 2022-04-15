Rails.application.routes.draw do
  root 'home#index'
  get 'about', to: 'home#about'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  delete 'registration/destroy', to: 'registrations#destroy'
end
