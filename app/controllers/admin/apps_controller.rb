module Admin
  class AppsController < BaseController
    def create
      apps = Courses.current.apps
      apps.find_each do |app|
        ArisService.publish(app)
      end
      redirect_to root_path, notice: "Recreated the apps.yml file for #{apps.count} Apps."
    end

    def update
      app = App.for_permalink_or_id(params[:id])
      ArisService.publish(app)
      redirect_to :back, notice: "Recreating app config for #{app.permalink}."
    end
  end
end
