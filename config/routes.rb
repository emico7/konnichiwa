Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  # authenticated :user do
  #   root 'secret#index', as: :authenticated_root
  # this should be questions#index
  # end

  get 'about' => 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
