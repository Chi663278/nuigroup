class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id #データの保存用
    if @post.save
      redirect_to timeline_path(@post), notice: 'ポストを投稿しました。'
    else
      flash.now[:notice] = 'ポストの投稿に失敗しました。'
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(is_active: false)
      redirect_to timeline_path(@post), notice: 'ポストを削除しました。'
    else
      flash.now[:notice] = 'ポストを削除できませんでした。'
      render :delete_post
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, :is_active)
  end

  def set_current_user
    @current_user = current_user
  end
end
