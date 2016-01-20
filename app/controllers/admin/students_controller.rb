module Admin
  class StudentsController < BaseController
    def show
      @students = User.includes(:apps).all
      @exercise_ids = ExercisePointMaster.new.exercise_ids
    end
  end
end
