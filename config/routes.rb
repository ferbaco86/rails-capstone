Rails.application.routes.draw do
  get 'sessions/log_in'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "categories#home" 
  resources :users
  resources :categories, except: [:edit, :update, :destroy]
  resources :sessions, except: [:destroy]
  resources :articles, except: [:destroy] do
    resources :votes, except: [:destroy]
  end
end
