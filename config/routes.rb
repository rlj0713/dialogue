Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#login'
  get 'sessions/login' => 'sessions#login'

  get '/auth/:provider/callback' => 'sessions#create'
  # get '/auth/google_oauth2/callback' => 'sessions#GoogleAuth'


  get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  
  get '/session', to: 'sessions#destroy'
  delete '/session', to: 'sessions#destroy'
end
