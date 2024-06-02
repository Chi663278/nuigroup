Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :users, only: [:index]
    get 'user_posts' => 'posts#user_posts', as: 'user_posts'
    resources :posts, only: [:show, :update]
    get 'user_comments' => 'comments#user_comments', as: 'user_comments'
    get 'post_comments' => 'comments#post_comments', as: 'post_comments'
    resources :comments, only: [:update]
    get 'following/:user_id' => 'follows#following', as: 'following'
    get 'follower/:user_id' => 'follows#follower', as: 'follower'
    get 'user_favs/:user_id' => 'favorites#user_favs', as: 'user_favs'
    get 'post_favs/:post_id' => 'favorites#post_favs', as: 'post_favs'
    resources :favorites, only: [:destroy]
  end



  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get 'TL' => 'users#index', as: 'timeline'
    get '/:screen_name' => 'users#show', as: 'user_timeline'
    get 'user/edit' => 'users#edit'
    patch 'user' => 'users#update'
    resources :posts, only: [:new, :create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resources :comments, only: [:new, :create]
    patch 'comments/:id' => 'comments#update', as: 'delete_comment'
    get 'following' => 'follows#following', as: 'following'
    get 'follower' => 'follows#follower', as: 'follower'
    resources :follows, only: [:create]
    delete 'follow/:id' => 'follows#destroy', as: 'delete_follow'
  end

end
