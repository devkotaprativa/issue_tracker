Rails.application.routes.draw do

  resources :projects do
    resources :issues do
      post 'issues/add_members'
      post 'issues/complete'
      get 'issues/show_members'
      get 'issues/processing'
      post 'issues/remove_members'
      get 'issues/reopen'
    end
    collection do
      get 'show_members'
      post 'remove_members'
    end
  end
  
  post 'projects/add_members'

  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root :to => 'projects#index'
    end
    unauthenticated :user do
      root :to => 'projects#home', as: :unauthenticated_root
    end
  end
end
