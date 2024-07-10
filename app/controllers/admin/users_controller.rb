class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def update
    user = User.find(params[:id])
    if user.is_active
      user.update!(is_active: false)
    else
      user.update!(is_active: true)
    end
    if user.is_active
      redirect_to admin_users_path(user), notice: 'ユーザーを有効にしました。'
    else
      redirect_to admin_users_path(user), notice: 'ユーザーを退会済みにしました。'
    end
  end
end
