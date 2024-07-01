# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?

  devise_for :users

  root 'static#index'

  controller :static do
    get :pages
  end

  namespace :api, format: :json do
    namespace :v1 do
      resource :sessions, only: %i[create destroy] do
        collection { post :verify_session }
      end
      resources :chats, only: %i[index show]
      resources :accounts, param: :username do
        member { get :public }
      end
      resources :quizzes, only: %i[index show] do
        resources :quiz_undertakings, only: %i[new create]
      end
    end
  end

  authenticated :user do
    get :dashboard, to: 'dashboard#index'
    resources :accounts
    resources :account_tokens, only: %i[index create destroy]
    resources :chats, only: %i[index show create destroy] do
      collection do
        get :group
        get :ai_chats
      end
      member do
        get :details
        post :autocomplete
      end
      resources :messages, only: %i[index create edit update destroy]
    end

    # TODO: Implement the functionality to destroy comments
    resources :comments, except: %i[show new destroy] do
      collection { get :reply }
    end
    resources :likes, only: %i[index create destroy]
    resources :posts
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

      resources :account_chat_maps, only: %i[index show destroy]
      resources :accounts, except: %i[new create]
      resources :admin_comments, except: :new
      resources :chats, only: %i[index show new create destroy]
      resources :comments, only: %i[index show destroy]
      resources :likes, only: %i[index show destroy]
      resources :messages
      resources :ml_models do
        resources :prediction_params, except: %i[index show]
        member do
          get :notebook_html
          post :prediction
        end
      end
      resources :prediction_params, only: %i[index show]
      resources :posts
      resources :solid_queues, only: :index
      resources :subreddit_posts, only: %i[index show delete]
      resources :subreddits do
        member { post :scrape_subreddit_posts }
      end
      resources :users
    end
  end
end
