Reddit::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts do
    resources :comments, only: [:new, :create]
  end
end
