class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def user_comments
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
  end

  def post_comments
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id)
  end

  def update
    comment = Comment.find(params[:id])
    if comment.is_active
      comment.update!(is_active: false)
    else
      comment.update!(is_active: true)
    end
    if comment.is_active
      redirect_to admin_user_comments_path(comment.user_id), notice: 'コメントを有効にしました。'
    else
      redirect_to admin_user_comments_path(comment.user_id), notice: 'コメントを削除しました。'
    end
  end
end
