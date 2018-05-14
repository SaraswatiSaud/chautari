Rails.application.routes.draw do
  resources :stations
  resources :categories
  devise_for :users

  post '/search', to: 'static_pages#search'
  root to: 'static_pages#home'
end
