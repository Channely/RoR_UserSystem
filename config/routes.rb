PbServer::Application.routes.draw do


  resources :users
  resources :sessions, only: [:new, :create, :destroy, :show]

  root 'navigates#home'
  match "help",     to: 'navigates#help',   via: 'get'

  match "add_user", to: 'users#new',        via: 'get'
  match "signup",   to: 'users#new',        via: 'get'
  match "signin",   to: 'sessions#new',     via: 'get'
  match "signout",  to: 'sessions#destroy', via: 'delete'
  match "check",    to: 'sessions#check',   via: 'post'


end
