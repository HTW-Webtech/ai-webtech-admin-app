class JenkinsController < ApplicationController
  before_action :only_admin_allowed

  def create
    apps = App.all
    JenkinsService.publish(apps)
    redirect_to root_path, notice: "Recreated jenkins_yaml for #{apps.count} apps."
  end

  private

  def only_admin_allowed
    current_user.admin?
  end
end
