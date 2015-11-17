Rails.application.routes.draw do
  get 'issues/index'

  get 'issues/show'

  get 'issues/new'

  get 'issues/edit'

  get 'issues/update'

  get 'issues/destroy'

  get 'issues/create'

  resources :projects
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
