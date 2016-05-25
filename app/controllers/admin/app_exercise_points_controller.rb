module Admin
  class AppExercisePointsController < BaseController
    def update
      app = App.for_permalink_or_id(params[:app_id])
      app.update exercise_points: params[:points]
      redirect_to :back, notice: "App #{app.display_name} hat nun #{app.exercise_points} Punkte"
    end
  end
end
