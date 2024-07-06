# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  def after_sign_in_path_for(resource)
    timeline_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:screen_name])
  end

  protected
  def reject_user
    @user = User.find_by!(screen_name: params[:user][:screen_name])
    return if @user.nil?
    return unless @user.valid_password?(params[:user][:password])
    if @user.is_active == false
        flash[:notice] = "ユーザーID: #{@user.screen_name}, ユーザー名: #{@user.name} は退会済みです。再度Sign upしてください。"
        redirect_to new_user_registration_path
    end
  end

end
