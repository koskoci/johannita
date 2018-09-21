Rails.application.routes.draw do
  resources :course_events, except: %i[new edit destroy] do
    member do
      post 'apply'
      patch 'confirm'
      patch 'cancel'
    end
  end
  resources :posts, except: %i[new edit] do
    member do
      post 'images'
    end
  end

  root 'welcome#index'
  resource :auth, only: %i[create]
  resources :attachments, only: %i[destroy]
  resources :users, except: %i[new edit] do
    member do
      post 'curriculum_vitaes'
      post 'cover_letters'
    end
  end

  resources :course_categories, except: %i[new edit]
  resources :participants, only: %i[index update]
  resources :email_confirmation, only: %i[update]
end
