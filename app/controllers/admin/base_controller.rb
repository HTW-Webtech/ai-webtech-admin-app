module Admin
  class BaseController < ::ApplicationController
    before_action :admin_required

    private

    def admin_required
      current_user && current_user.admin?
    end
  end
end
