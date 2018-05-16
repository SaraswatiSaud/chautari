Rails.application.routes.draw do
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/faq', to: 'static_pages#faq'
  get '/privacy-policy', to: 'static_pages#privacy_policy'

  resources :stations
  resources :categories
  devise_for :users

  root to: 'static_pages#home'
end
