Rails.application.routes.draw do
  scope '/api' do
    resources :attendances, only: %i[index create destroy]
    resources :course_events, except: %i[new edit destroy]

    resources :courses, except: %i[new edit destroy] do
      member do
        post 'apply'
        patch 'confirm'
        patch 'cancel'
      end
    end

    resources :posts, except: %i[new edit]
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
    resources :pages, except: %i[new edit] do
      member do
        post 'attachments'
      end
    end
    post '/embedded_image', to: 'images#create_embedded'
    post '/thumbnail', to: 'images#create_thumbnail'
  end

  root to: "catch_all#index", via: :all
  get '*path', to: 'catch_all#index', via: :all, constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
