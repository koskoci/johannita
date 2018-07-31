Rails.application.routes.draw do
  resources :posts
  resource :auth, only: %i[create]
  root 'welcome#index'
end
