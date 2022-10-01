Rails.application.routes.draw do
  use_doorkeeper
  get '/users/email_get', to: 'users#email_get', as: 'users_email_get'
  post '/users/email_post', to: 'users#email_post', as: 'users_email_post'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions do
    post :subscribe, on: :member
    post :unsubscribe, on: :member
    resources :answers, shallow: true do
      member do
        get 'position'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
        get :exept_me, on: :collection
      end
      resources :questions do
        resources :answers
      end
    end
  end

  resources :attachments, only: [:destroy]
  resources :comments, only: [:create]
  post '/votes/votes_down', to: 'votes#votes_down', as: 'votes_down'
  post '/votes/votes_up', to: 'votes#votes_up', as: 'votes_up'
  post '/votes/votes_cancel', to: 'votes#votes_cancel', as: 'votes_cancel'

  get 'search', to: 'search#search'

  root to: "questions#index"

  mount ActionCable.server => '/cable'

end
