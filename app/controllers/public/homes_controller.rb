class Public::HomesController < ApplicationController
  def top
  end

  def search
    @category = params[:category]
    @query = params[:query]

    if @category.present? && @query.present?
      case @category
      when 'screen_name'
        @results = User.only_active.where('screen_name LIKE ?', "%#{@query}%")
      when 'user'
        @results = User.only_active.where('name LIKE ?', "%#{@query}%")
      when 'post'
        @results = Post.only_active.where('caption LIKE ?', "%#{@query}%").order(created_at: :desc)
        @comments = Comment.only_active.where(post_id: @results.pluck(:id)).order(created_at: :asc)
      else
        @results = []
      end
    else
      @results = []
    end

    if @results.empty?
      redirect_to timeline_path, notice: '検索 - 該当結果がありません。'
    else
      render :search
    end
  end
end
