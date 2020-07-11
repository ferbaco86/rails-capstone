Rails.application.routes.draw do
  get 'sessions/log_in'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "categories#home" 
  resources :users
  resources :categories
  resources :sessions
  resources :articles do
    resources :votes
  end
end
