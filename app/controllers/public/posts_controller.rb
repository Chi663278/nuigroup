class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to timeline_path(@post), notice: 'ポストしました。'
    else
      flash.now[:notice] = 'ポストに失敗しました。'
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.update!(is_active: false)
    redirect_back fallback_location: timeline_path(current_user), notice: 'ポストを削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find(params[:id])
    redirect_to timeline_path(current_user) unless @post
  end
end
