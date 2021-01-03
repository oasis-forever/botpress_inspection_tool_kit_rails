Rails.application.routes.draw do
  root 'top#index'
  get  '/top'                          => 'top#index'
end
