class UsersController < ::BaseController
  def show
    @user = fetch_user
    @apps = @user.apps.order(id: :asc)
  end

  def edit
    @user = fetch_user
  end

  def update
    @user = fetch_user
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    redirect_to current_user
  end

  private

  def fetch_user
    User.find(params[:id]).tap do |user|
      redirect_to current_user unless user == current_user
    end
  end

  def user_params
    params.require(:user).permit(:name, :ssh_key, :password, :password_confirmation, :reset_password_token)
  end
end
