require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  authenticate :user, -> (user) { user.is_admin? } do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :donate_events

  root "home#index"

  mount ApiRoot => ApiRoot::PREFIX
end
