Rails.application.routes.draw do

  root 'ideas#index'

  resources :ideas do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :ideas do
    resources :likes, only: [:create, :destroy]
  end

end
