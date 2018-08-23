Rails.application.routes.draw do
  resources :events do
    member do
      post 'apply'
      patch 'confirm'
      patch 'cancel'
    end
  end
  resources :posts do
    member do
      get 'select_image'
      post 'images'
    end
  end

  root 'welcome#index'
  resource :auth, only: %i[create]
  resources :attachments, only: %i[destroy]
  resources :users, except: %i[new edit create]
end
