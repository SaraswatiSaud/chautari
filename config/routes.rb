Rails.application.routes.draw do
  resources :countries
  resources :languages
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/faq', to: 'static_pages#faq'
  get '/privacy-policy', to: 'static_pages#privacy_policy'

  resources :stations do
    get 'play', on: :member
    get 'player_close', on: :collection
  end

  resources :categories
  devise_for :users

  root to: 'static_pages#home'
end
