# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :players
  root 'games#index'
  resources :games
  resources :pieces, only: :update
  resource :dashboard, only: :show
end
