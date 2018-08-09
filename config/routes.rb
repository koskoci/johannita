Rails.application.routes.draw do
  resources :events do
    post 'apply', on: :member
  end
  resources :posts
  resource :auth, only: %i[create]
  root 'welcome#index'
end
