class UsersController < ApplicationController
  def show
    @user = fetch_user
    @apps = @user.apps
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
end
