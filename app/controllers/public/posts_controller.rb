class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to timeline_path(@post), notice: 'ポストを投稿しました。'
    else
      flash.now[:notice] = 'ポストの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.update!(is_active: false)
    redirect_to timeline_path(post), notice: 'ポストを削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
