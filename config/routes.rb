Rails.application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders, only: [:index, :create, :edit, :new]
  patch 'orders/:id', to: 'orders#update' # seems to conflict with the :order shortcut...
  get 'orders/:id', to: 'orders#index', as: :order # non-conventional
  resources :items
  #get 'items', to: 'items#index', as: :items
  #get 'items/:id', to: 'items#index', as: :item
  resources :users

  # Toggling and order item
  get 'toggle/:id', to: 'order_items#toggle', as: :toggle

  # Logging in and out
  resources :sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  # cart
  get 'add-to-cart/:item_id' => 'cart#add', as: :add_cart
  get 'cart' => 'cart#index', as: :cart
  get 'remove-from-cart/:item_id' => 'cart#remove', as: :remove_cart
  get 'subtract-from-cart/:item_id' => 'cart#sub', as: :sub_cart
  #resources :cart, only: [:index]

  # dashboards
  get 'shipping' => 'home#shipping', as: :shipping
  get 'baking' => 'home#baking', as: :baking

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  # Set the root url
  root :to => 'home#home'

end
