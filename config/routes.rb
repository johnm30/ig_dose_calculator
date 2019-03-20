Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/calculations', to: 'calculations#new'       # Produce form for creating a new case
  get '/calculations', to: 'calculations#show'      # show the page for new diagnose disease result without saving case - don;t need now
  get '/calculations/index', to: 'calculations#index'     # show the results for all AC to export as a table

  get '/trials', to: 'trials#show'
  delete	'/trials', to:	  'trials#destroy'	  #delete a specific trial
  get '/trials/index', to: 'trials#index'     # show the results for all AC to export as a table

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :calculations,     only: [:create, :index]
  resources :trials,     only: [:show, :destroy]
end
