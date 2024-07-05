class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:destroy]

  def new
    @comment = Comment.new
    session[:previous_url] = request.referer
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to session[:previous_url], notice: 'コメントしました。'
    else
      flash.now[:notice] = 'コメントに失敗しました。'
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.update!(is_active: false)
    redirect_back fallback_location: timeline_path(current_user), notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def ensure_user
    @comments = current_user.comments
    @comment = @comments.find_by(id: params[:id])
    redirect_to timeline_path(current_user) unless @comment
  end
end
