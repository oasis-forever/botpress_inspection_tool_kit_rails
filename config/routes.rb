Rails.application.routes.draw do
  root 'top#index'
  get  '/top'                          => 'top#index'
  get  '/json-converters/select-csv'   => 'json_converters#select_csv'
  post '/json-converters/download'     => 'json_converters#download'

  get '/json-converters/download'     => redirect('/json-converters/select-csv')
end
