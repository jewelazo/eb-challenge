Rails.application.routes.draw do
  
  root to: 'properties#index'
  get 'properties/:id', to: 'properties#show'
  post 'properties/:id/new_contact',to: 'properties#create_contact'
end
