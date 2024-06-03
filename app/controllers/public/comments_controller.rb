class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to timeline_path(@comment), notice: 'コメントを投稿しました。'
    else
      flash.now[:notice] = 'コメントの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.update!(is_active: false)
    redirect_to timeline_path(comment), notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
