Rails.application.routes.draw do
  get 'search' => "searches#search"
  get 'result' => "searches#result"

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :tags, only: [:index, :create, :destroy]
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :reports, only: [:index, :show, :update]
    get 'search' => 'searches#search'
    get 'result' => 'searches#result'
  end

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'followings'
        get 'followers'
        get 'favorites'
        get 'stars'
        get 'check'
        patch 'leave'
      end
      resource :relationships, only: [:create, :destroy]
      resources :reports, only: [:new, :create]
    end
    resources :posts, except: [:destroy] do
      member do
        patch 'delete'
      end
      resource :favorites, only: [:create, :destroy]
      resource :stars, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy] do
        resources :actions, only: [:create, :destroy]
      end
    end
    resources :rooms, only: [:index] do
      collection do
         get 'lists'
      end
    end
    resources :chats, only: [:show, :create]
    resources :notifications, only: [:index]
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    resources :contacts, only: [:new, :create] do
      collection do
        get 'done'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
