Rails.application.routes.draw do
  require 'sidekiq/web'
  
  resources :messages
  devise_for :users
  root "messages#index"
  get "home" => "pages#home"
  mount Sidekiq::Web, at: '/sidekiq'

  
  # SMS routes
  resources :outbound_sms,          only: [:index, :create]
  resources :sms_delivery_receipts, only: [:create]
  resources :inbound_sms,           only: [:create]

  # Phone Call routes
  resources :outbound_calls, only: [:index, :create, :show]
  resources :call_events,    only: [:create]
  resources :inbound_calls,  only: [:create]
end
