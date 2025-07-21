Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root :to => "web/boards#show"
    
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show]
    end
  end
  
  namespace :admin do
    resources :users
  end
  
  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resources :developers, only: [:new, :create]
    resources :password_resets, only: [:new, :create, :edit, :update]
    
  end
end