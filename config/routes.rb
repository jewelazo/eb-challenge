Rails.application.routes.draw do
  
  root to: 'properties#index'
  get 'properties/:id', to: 'properties#show'
end
