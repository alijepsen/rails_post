Rails.application.routes.draw do
  root 'posts#index' #always a root, default path "root route"

  resources :posts
end
