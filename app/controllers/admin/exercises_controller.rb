module Admin
  class ExercisesController < BaseController
    def show
      @exercise_ids = Exercise.active_ids
      @apps = App.all
    end
  end
end
