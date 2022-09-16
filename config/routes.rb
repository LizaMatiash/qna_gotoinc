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

  root to: "questions#index"

end
