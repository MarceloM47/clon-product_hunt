Rails.application.routes.draw do
  resources :categories
  #get 'products/', to: 'products#index'
  #get 'products/new', to: 'products#new'

  #get 'products/:id', to: 'products#show', as: :product

  #get '/products/:id/edit', to: 'products#edit', as: :edit_product
  #patch '/products/:id/', to: 'products#update'

  #post 'products', to: 'products#create'

  resources :products do
    get 'search', on: :collection # products/search -> products#search
    resources :comments, only: [:create]
  end

  root "main#welcome"
end
