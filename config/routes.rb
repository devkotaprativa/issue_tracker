Rails.application.routes.draw do
  resources :projects

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
