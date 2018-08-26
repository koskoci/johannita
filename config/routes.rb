Rails.application.routes.draw do
  resources :events, except: %i[new edit destroy] do
    member do
      post 'apply'
      patch 'confirm'
      patch 'cancel'
    end
  end
  resources :posts, except: %i[new edit] do
    member do
      get 'select_image'
      post 'images'
    end
  end

  root 'welcome#index'
  resource :auth, only: %i[create]
  resources :attachments, only: %i[destroy]
  resources :users, except: %i[new edit create] do
    member do
      get 'select_curriculum_vitae'
      post 'curriculum_vitaes'
      get 'select_cover_letter'
      post 'cover_letters'
    end
  end
end
