Rails.application.routes.draw do

  resources :publishers
  get '/'  => "sessions#welcome"
  
  # Login, Log Out, and Sign Up
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create' #Only used for URL. 
  delete '/logout' => 'sessions#destroy'
  get '/logout' => 'sessions#destroy'

  get 'manga/:id' => 'mangas#show'



  resources :reviews
  resources :mangas do
    resources :reviews, only: [:new, :index]
  end
  resources :genres
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#welcome'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  
end