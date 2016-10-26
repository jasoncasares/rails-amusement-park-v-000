Rails.application.routes.draw do

  resources :users, :attractions

  root 'attractions#index'

  get '/users/new', to: 'users#new', as: 'signup'

  post '/users/:id', to: 'users#ride'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

end
