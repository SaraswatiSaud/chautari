Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/404', to: 'errors#not_found', via: :all
  get '/422', to: 'errors#unacceptable', via: :all
  get '/500', to: 'errors#internal_error', via: :all

  resources :countries
  resources :languages
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  post '/contact', to: 'static_pages#contact'
  get '/faq', to: 'static_pages#faq'
  get '/privacy-policy', to: 'static_pages#privacy_policy'

  get '/favorites', to: 'favorites#index'

  resources :stations do
    member do
      get 'play'
      get 'playing_now'
      get 'similar'
      get 'thankyou'
    end

    collection do
      get 'player_close'
    end

    resources :reviews, only: %i[new create destroy]
    resources :favorites, only: %i[create destroy]
  end

  resources :categories, path: :genres
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :countries, only: %i[index show]
      resources :languages, only: %i[index show]
      resources :categories, only: %i[index show]
      resources :stations, only: %i[index show]
    end
  end

  root to: 'static_pages#home'
end
