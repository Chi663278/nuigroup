class Public::HomesController < ApplicationController
  def top
  end

  def search
    @category = params[:category]
    @query = params[:query]

    if @category.present? && @query.present?
      case @category
      when 'user'
        @results = User.where('name LIKE ?', "%#{@query}%")
      when 'post'
        @results = Post.where('caption LIKE ?', "%#{@query}%")
      else
        @results = []
      end
    else
      puts "@results: #{@results.inspect}"
    end

    if @results.empty?
      redirect_to timeline_path, alert: '該当結果がありません。'
    else
      render :search
    end
  end
end
