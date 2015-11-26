module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :redirect_non_admin_user

    private

    def redirect_non_admin_user
      if !current_user.admin?
        redirect_to user_path(current_user)
      end
    end
  end
end
