Reddit::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
end
