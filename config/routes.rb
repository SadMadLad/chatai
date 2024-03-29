# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?

  devise_for :users

  root 'static#index'
  
  controller :static do
    get :pages
  end

  authenticated :user do
    get :dashboard, to: 'dashboard#index'

    resources :chats, only: %i[index show create destroy] do
      collection do
        get :group
        get :ai_chats
      end
      member do
        get :details
        post :autocomplete
      end
      resources :messages, only: %i[create edit update destroy]
    end
    resources :accounts, only: %i[show edit update destroy]

    resources :ml_models, only: %i[index show] do
      member do
        get :notebook_html
        post :prediction
      end
    end
  end

  authenticated :user, ->(user) { user.account.can_moderate? } do
    get 'up' => 'rails/health#show', as: :rails_health_check
    namespace :admin do
      get :dashboard, to: 'dashboard#index'

      resources :users
      resources :accounts, except: %i[new create]
      resources :account_chat_maps, only: %i[index show destroy]
      resources :admin_comments, except: :new
      resources :chats, only: %i[index show new create destroy]
      resources :messages
      resources :prediction_params, only: %i[index show]

      resources :ml_models do
        resources :prediction_params, except: %i[index show]
        member do
          get :notebook_html
          post :prediction
        end
      end

      resources :solid_queues, only: :index do
        collection do
          get :blocked_executions
          get :claimed_executions
          get :failed_executions
          get :pauses
          get :processes
          get :ready_executions
          get :scheduled_executions
          get :semaphores
        end
      end
    end
  end
end
