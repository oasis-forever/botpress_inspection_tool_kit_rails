Rails.application.routes.draw do
  root 'top#index'
  get '/top', to: 'top#index'
  get '/training-data/select', to: 'training_data#select'
  post '/training-data/download', to: 'training_data#download'
  get '/qa-inspectors/select', to: 'qa_inspectors#select'
  post '/qa-inspectors/chart', to: 'qa_inspectors#chart'
  post '/qa-inspectors/export', to: 'qa_inspectors#export', default: { format: :csv }

  get '/training-data/download', to: redirect('/training-data/select')
  get '/qa-inspectors/chart', to: redirect('/qa-inspectors/select')
end
