Rails.application.routes.draw do

  get 'albums/new'

  get 'albums/create'

  get 'albums/edit'

  get 'albums/update'

  get 'albums/index'

  get 'albums/show'

  get 'albums/destroy'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  #singular resource / singular session
  resources :bands

end
