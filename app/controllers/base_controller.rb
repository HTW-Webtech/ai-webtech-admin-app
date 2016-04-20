class BaseController < ::ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :redirect_users_to_users_namespace
  before_action :ensure_user_belongs_to_one_group

  def ensure_user_belongs_to_one_group
    if current_user && current_user.groups.empty?
      current_user.groups << Group.current_course
    end
  end

  def redirect_users_to_users_namespace
    if current_user && !current_user.admin? && !request.path.start_with?("/users/")
      redirect_to user_path(current_user)
    end
  end

  def after_sign_in_path_for(_)
    user_path(current_user)
  end
end
