Rails.application.routes.draw do
  resources :events
  resources :posts
  resource :auth, only: %i[create]
  root 'welcome#index'
end
