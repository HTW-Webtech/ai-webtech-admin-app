module Admin
  class JenkinsController < BaseController
    def create
      apps = Course.current.apps
      JenkinsService.publish(apps)
      redirect_to root_path, notice: "Recreated jenkins_yaml for #{apps.count} apps."
    end
  end
end
