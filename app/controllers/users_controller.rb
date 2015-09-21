class UsersController < ApplicationController
  def show
    @user = current_user
    @apps = current_user.apps
  end
end
