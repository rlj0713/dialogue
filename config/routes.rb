Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#choice'
  get '/auth/:provider/callback' => 'sessions#create'

  post '/show' => 'sessions#show'

  delete '/session', to: 'sessions#destroy'

  resources :sessions
  resources :coaches
  resources :teachers
  resources :posts
end
