module Admin
  class ExercisePointsController < BaseController
    def create
      App.find_each do |app|
        ExercisePointMaster.new.evaluate_app!(app)
      end
      redirect_to root_path, notice: "Updated exercise points for #{App.count} apps."
    end
  end
end
