Rails.application.routes.draw do
  resources :topics do
    resources :questions, except: [:index]
  end

  resources :questions, only: [:index] do
    resources :answers, only: [:create, :destroy]
  end


  get 'users/show'

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  authenticated :user do
    root 'topics#index', as: :authenticated_root
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
