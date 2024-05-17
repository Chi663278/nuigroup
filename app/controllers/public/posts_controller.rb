class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
  end

  def update
    @post.update(post_params) ? (redirect_to timeline_path(@post)) : (render :new)
  end

  def post_params
    params.require(:post).permit(:image, :caption, :is_active)
  end
end
