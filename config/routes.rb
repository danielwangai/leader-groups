Rails.application.routes.draw do
  resources :events do
    resource :event_members
  end
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
end
