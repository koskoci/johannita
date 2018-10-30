Rails.application.routes.draw do
  scope '/api' do
    resources :course_events, except: %i[new edit destroy]

    resources :courses, except: %i[new edit destroy] do
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

    resources :users, except: %i[new edit] do
      member do
        post 'curriculum_vitaes'
        post 'cover_letters'
      end
    end

    resource :auth, only: %i[create]
    resources :attachments, only: %i[destroy]
    resources :course_categories, except: %i[new edit]
    resources :participants, only: %i[index update]
    resources :email_confirmation, only: %i[show]
  end

  get '*path', to: 'catch_all#index', constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
