Rails.application.routes.draw do

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'

  get 'password_resets/new'
  get 'password_resets/edit'

  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/calculations', to: 'calculations#new'       # Produce form for creating a new case
  get '/calculations/show', to: 'calculations#show' # expands or contracts the indication on the calculations form

  get '/diseases', to: 'diseases#new'
  get  '/diseases/edit', to: 'diseases#edit'
  delete '/diseases', to: 'diseases#destroy'
  put '/diseases', to: 'diseases#show'
  get '/diseases/index', to: 'diseases#index'   #Actually this is just to show one disease from link when show the differential diagnosis
  patch '/diseases', to: 'diseases#expander', as: 'expander'

  #try and point diseases export action - the "view" is export.xlsx.axlsx
  get '/diseases/export', to: 'diseases#export'

  #try and point diseases sort action - redo new if comes from new and edit if comes from edit, possibly show as well
  get '/diseases/sort', to: 'diseases#sort'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :calculations,     only: [:create, :show]
  resources :diseases,       only: [ :new, :edit, :create, :update, :index, :export, :sort]

end
