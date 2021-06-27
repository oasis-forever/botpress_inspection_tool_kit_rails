Rails.application.routes.draw do
  root 'top#index'
  get '/top', to: 'top#index'
  get '/training-data/select', to: 'training_data#select'
  post '/training-data/download', to: 'training_data#download'

  get '/training-data/download', to: redirect('/training-data/select')
end
