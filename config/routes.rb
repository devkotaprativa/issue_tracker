Rails.application.routes.draw do

  resources :projects do
    resources :issues
    post 'issues/show_members'
    post 'issues/add_members'
  end
  post 'projects/show_members'
  post 'projects/add_members'

  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root :to => 'projects#index'
    end
    unauthenticated :user do
      root :to => 'projects#index', as: :unauthenticated_root
    end
  end
end
