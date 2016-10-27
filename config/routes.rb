Rails.application.routes.draw do
  get 'rooms/show'

  resources :archives
  resources :reports
  resources :members
  resources :groups
  devise_for :users

  root to: 'home#index'

  scope "/profiles" do
    resources :users
  end
  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'
end
