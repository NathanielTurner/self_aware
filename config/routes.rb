Rails.application.routes.draw do
  resources :stats
  get 'budgets/new'
  get 'budgets/edit'
  get 'budgets/destroy'
  delete 'withdrawal' => 'budgets#destroy_withdrawal'
  get 'budgets/show'
  get 'budgets/new_deposit'
  get 'budgets/new_withdrawal'
  post'budgets/new_deposit'
  post'budgets/new_withdrawal'
  resources :budgets
  get 'completed/tasks' => 'tasks#show'
  get 'tasks/edit'
  get 'tasks/destroy'
  get 'tasks/new'
  get 'tasks/history'
  resources :tasks
  root to: 'home#home'
  get 'home/home'
  get 'home/show'
  resources :home
  devise_for :users
  get 'tasks/set_submit'
  post 'tasks/set_submit'
  resources :stats
end
