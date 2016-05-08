module Admin
  class JenkinsController < BaseController
    def create
      apps = Courses.current.apps
      JenkinsService.publish(apps)
      redirect_to root_path, notice: "Recreated jenkins_yaml for #{apps.count} apps."
    end

    def update
      app = App.for_permalink_or_id(params[:id])
      JenkinsService.publish(app)
      redirect_to :back, notice: "Recreating jenkins config for #{app.permalink}."
    end
  end
end
