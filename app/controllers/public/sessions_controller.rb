# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    timeline_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:screen_name])
  end
end
