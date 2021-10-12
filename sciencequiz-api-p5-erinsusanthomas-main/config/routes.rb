Rails.application.routes.draw do
  #Routes for OrganizationsController
  get 'organizations', to: 'organizations#index', as: :organizations
  post 'organizations', to: 'organizations#create'
  get 'organizations/:id', to: 'organizations#show', as: :organization
  patch 'organizations/:id', to: 'organizations#update'
  delete 'organizations/:id', to: 'organizations#destroy'

  root to: 'organizations#index'
end
