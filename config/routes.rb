Rails.application.routes.draw do
  namespace :public do
    get 'follows/following'
    get 'follows/follower'
    get 'follows/create'
    get 'follows/destroy'
  end
  namespace :public do
    get 'comments/new'
    get 'comments/create'
    get 'comments/update'
  end
  namespace :public do
    get 'favorites/index'
    get 'favorites/create'
    get 'favorites/update'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/create'
    get 'posts/update'
  end
  namespace :public do
    get 'users/index'
    get 'users/edit'
    get 'users/update'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/timeline'
  end
  namespace :admin do
    get 'favorites/user_favs'
    get 'favorites/post_favs'
    get 'favorites/update'
  end
  namespace :admin do
    get 'follows/following'
    get 'follows/follower'
  end
  namespace :admin do
    get 'comments/user_comments'
    get 'comments/post_comments'
    get 'comments/update'
  end
  namespace :admin do
    get 'posts/user_posts'
    get 'posts/show'
    get 'posts/update'
  end
  namespace :admin do
    get 'users/index'
  end
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }


end
