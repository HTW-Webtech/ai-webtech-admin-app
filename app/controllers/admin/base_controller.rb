module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :redirect_non_admin_user
    before_action :set_current_course

    private

    def set_current_course
      if current_course = params[:current_course] || session[:current_course]
        @current_course = Courses.find current_course
        session[:current_course] = current_course
      end
    end

    def redirect_non_admin_user
      if !current_user.admin?
        redirect_to user_path(current_user)
      end
    end

    def current_course
      @current_course ||= Courses.current
    end
  end
end
