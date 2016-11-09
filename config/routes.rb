Rails.application.routes.draw do
  resources :broadcasts
  get 'notices/incoming'

  resources :archives
  resources :reports
  resources :members
  resources :groups
  devise_for :users

  root to: 'home#index'

  scope "/profiles" do
    resources :users
  end

  # post 'incoming' => 'notices#incoming', as: 'incoming'
  post 'create' => 'reports#create', as: 'create'

  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
