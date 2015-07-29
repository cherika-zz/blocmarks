Rails.application.routes.draw do
  
  devise_for :users

  resources :users

  resources :bookmarks

  post :incoming, to: 'incoming#create'

  root :to => "welcome#index"
end
