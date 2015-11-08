Rails.application.routes.draw do
 

  devise_for :users

  authenticated :user do
    root 'users#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end

  get '/users/profile', to: 'users#profile'

post "users/checkout", to: 'users#checkout'
get "users/clienttoken", to: 'users#clienttoken'

end
