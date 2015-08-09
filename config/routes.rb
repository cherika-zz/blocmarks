Rails.application.routes.draw do

  resources :topics do
    resources :bookmarks
  end

  devise_for :users

  resources :users

  post :incoming, to: 'incoming#create'

  root :to => "welcome#index"
end
