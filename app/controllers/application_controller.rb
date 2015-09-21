class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :redirect_users_to_users_namespace

  def redirect_users_to_users_namespace
    if current_user && !current_user.admin? && !request.path.start_with?("/users/")
      redirect_to user_path(current_user)
    end
  end

  def after_sign_in_path_for(_)
    current_user.admin? ? rails_admin.dashboard_path : users_path(current_user)
  end
end
