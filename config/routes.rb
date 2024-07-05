Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :users, only: [:index]
    get 'user:id/posts' => 'posts#user_posts', as: 'user_posts'
    resources :posts, only: [:show, :update]
    get 'user:id/comments' => 'comments#user_comments', as: 'user_comments'
    get 'post:id/comments' => 'comments#post_comments', as: 'post_comments'
    resources :comments, only: [:update]
    get 'user:id/followings' => 'follows#following', as: 'following'
    get 'user:id/followers' => 'follows#follower', as: 'follower'
    get 'user:id/favs' => 'favorites#user_favs', as: 'user_favs'
    get 'post:id/favs' => 'favorites#post_favs', as: 'post_favs'
  end



  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get 'TL' => 'users#index', as: 'timeline'
    get 'users/:screen_name' => 'users#show', as: 'user_timeline'
    resource :user, only: [:edit, :update, :destroy]
    get 'user/withdraw' => 'users#withdraw'
    get 'bye' => 'users#bye'
    resources :users, only: [], param: :screen_name do
      resource :relationships, only: [:create, :destroy]
      member do
        get :followings, :followers
      end
    end
    resources :posts, only: [:new, :create, :destroy] do
      resources :favorites, only: [:index]
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:new, :create, :destroy]
    end
    get 'favorites' => 'favorites#user_favs', as: 'user_favs'
    get 'search' => 'homes#search', as: 'search'
  end

end
