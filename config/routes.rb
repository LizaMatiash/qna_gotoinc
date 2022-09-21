Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers, shallow: true do
      member do
        get 'position'
      end
    end
  end

  resources :attachments, only: [:destroy]
  post '/votes/votes_down', to: 'votes#votes_down', as: 'votes_down'
  post '/votes/votes_up', to: 'votes#votes_up', as: 'votes_up'
  post '/votes/votes_cancel', to: 'votes#votes_cancel', as: 'votes_cancel'

  root to: "questions#index"

end
