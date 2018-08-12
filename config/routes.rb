Rails.application.routes.draw do
  resources :events do
    member do
      post 'apply'
      patch 'confirm'
      patch 'cancel'
    end
  end
  resources :posts
  resource :auth, only: %i[create]
  root 'welcome#index'
end
