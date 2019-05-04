Rails.application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders, only: [:index, :create, :edit, :new]
  patch 'orders/id', to: 'orders#update' # seems to conflict with the :order shortcut...
  get 'orders/:id', to: 'orders#index', as: :order # non-conventional
  resources :items
  #get 'items', to: 'items#index', as: :items
  #get 'items/:id', to: 'items#index', as: :item
  resources :users

  # Logging in and out
  resources :sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  # cart
  get 'add-to-cart/:item_id' => 'cart#add', as: :add_cart
  get 'cart' => 'cart#index', as: :cart
  #resources :cart, only: [:index]

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  # Set the root url
  root :to => 'home#home'

end
