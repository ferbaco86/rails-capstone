Rails.application.routes.draw do
  get 'sessions/log_in'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "articles#index" 
  resources :users
  resources :articles
  resources :categories
  resources :votes
  resources :sessions
end
