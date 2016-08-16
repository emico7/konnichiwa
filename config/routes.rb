Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  authenticated :user do
    root 'users#show', as: :authenticated_root
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
