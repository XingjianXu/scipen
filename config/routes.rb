Rails.application.routes.draw do

  get 'home/lab'

  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  get 'lab', to: 'lab#show'

  resources :categories

  resources :profiles
  scope as: :current_user do
    resource :profile
  end

  resources :spaces do
    resources :articles
  end

  resources :articles do
    member do
      get 'assets'
      post 'assets'
      get 'asset'
      delete 'asset'
    end
  end

  root to: 'home#index'
end
