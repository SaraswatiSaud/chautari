Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root to: 'static_pages#home'
end
