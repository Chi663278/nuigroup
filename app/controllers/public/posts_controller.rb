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
    if @post.update(post_params)
      redirect_to timeline_path(@post), notice: 'ポストを更新しました。'
    else
      flash.now[:notice] = 'ポストの更新に失敗しました。'
      render :update
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, :is_active)
  end

  def set_current_user
    @user = current_user
  end
end
