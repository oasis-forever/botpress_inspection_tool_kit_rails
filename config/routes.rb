Rails.application.routes.draw do
  root 'top#index'
  get  '/top'                          => 'top#index'
  get  '/json-converters/select-csv'   => 'json_converters#select_csv'
  post '/json-converters/download'     => 'json_converters#download'
  get  '/converse-api/select-data'     => 'converse_api#select_data'
  post '/converse-api/generate-matrix' => 'converse_api#generate_matrix'
  post '/converse-api/export-matrix'   => 'converse_api#export_matrix', default: { format: :csv }

  get '/json-converters/download'     => redirect('/json-converters/select-csv')
  get '/converse-api/generate-matrix' => redirect('/converse-api/select-data')
end
