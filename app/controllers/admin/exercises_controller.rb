module Admin
  class ExercisesController < BaseController
    def show
      @exercise_ids = ExercisePointMaster.new.exercise_ids
      @apps = App.all
    end
  end
end
