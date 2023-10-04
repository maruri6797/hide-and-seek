Rails.application.routes.draw do
  get 'search' => "searches#search"
  get 'result' => "searches#result"
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "admin#top"
    resources :tags, only: [:index, :create, :destroy]
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'posts'
      end
    end
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:destroy]
  end

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :users, except: [:new, :create, :destroy] do
      member do
        get 'followings'
        get 'followers'
        get 'favorites'
        get 'check'
        patch 'leave'
      end
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create]
    resources :notifications, only: [:index]
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
