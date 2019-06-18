Rails.application.routes.draw do

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'


  get '/calculations', to: 'calculations#new'       # Produce form for creating a new case

  resources :calculations,     only: [:create]

end
