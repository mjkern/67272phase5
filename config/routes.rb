Rails.application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items
  resources :users

  # Logging in and out
  resources :sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  # cart
  post 'add-to-cart/:item_id' => 'cart#add', as: :add_cart

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  # Set the root url
  root :to => 'home#home'

end
