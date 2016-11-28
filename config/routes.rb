Rails.application.routes.draw do
  resources :harambees
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

  # post '/harambees/:id' => 'harambees#show'#, as: 'harambee_make_contribution'

  post '/harambees/:id/make_contribution' => 'harambees#make_contribution', as: 'harambee_make_contribution'

  resources :roles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
