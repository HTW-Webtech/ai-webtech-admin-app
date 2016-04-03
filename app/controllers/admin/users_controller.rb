module Admin
  class UsersController < BaseController
    def block
      user = User.find(params[:user_id])
      if user.block!
        redirect_to user, notice: 'User has been successfully blocked.'
      else
        redirect_to user, alert: 'Could not block user!'
      end
    end

    def unblock
      user = User.find(params[:user_id])
      if user.unblock!
        redirect_to user, notice: 'User has been successfully unblocked.'
      else
        redirect_to user, alert: 'Could not unblock user!'
      end
    end
  end
end
