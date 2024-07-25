class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to timeline_path, notice: 'ポストしました。' }
        format.js { redirect_to timeline_path, notice: 'ポストしました。' }
      end
    else
      respond_to do |format|
        flash.now[:notice] = 'ポストに失敗しました。'
        format.html { render :new }
        format.js
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.update!(is_active: false)
    redirect_back fallback_location: timeline_path, notice: 'ポストを削除しました。'
  end

  def preview
    respond_to format.js { render '/app/javascript/packs/preview.js' }
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find(params[:id])
    redirect_to timeline_path unless @post
  end
end
