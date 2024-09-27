# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :backoffice do
    resources :shows
  end
  root 'shows#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  controller :backoffice do
    get 'backoffice' => :show
  end

  resources :shows
  resources :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
