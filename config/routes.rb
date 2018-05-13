Rails.application.routes.draw do
  resources :stations
  resources :categories
  devise_for :users
  root to: 'static_pages#home'
end
