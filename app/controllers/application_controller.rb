class ApplicationController < ActionController::Base
  before_action :set_admin
  before_action :set_user


  private

  def set_admin
    @current_admin = current_admin
  end

  def set_user
    @current_user = current_user
  end
end
