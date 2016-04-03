class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    if logged_in_user_blocked?
      env['warden'].logout
      redirect_to '/', alert: 'You account is blocked and you can not login anymore.'
    else
      super
    end
  end

    private

    def logged_in_user_blocked?
      current_user && current_user.blocked?
    end
end
