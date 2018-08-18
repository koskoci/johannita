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
      patch 'upload_image'
      delete 'delete_image'
    end
  end

  resource :auth, only: %i[create]
  root 'welcome#index'
end
