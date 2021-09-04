require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :donate_events

  root "home#index"
end
