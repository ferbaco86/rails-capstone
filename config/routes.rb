Rails.application.routes.draw do
  get 'votes/new'
  get 'votes/create'
  get 'votes/destroy'
  get 'categories/new'
  get 'categories/create'
  get 'categories/update'
  get 'categories/destroy'
  get 'articles/new'
  get 'articles/show'
  get 'articles/create'
  get 'articles/update'
  get 'articles/destroy'
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
