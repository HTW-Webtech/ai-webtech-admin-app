module Admin
  class ExercisesController < BaseController
    def show
      @exercise_ids = ExercisePointMaster.new(current_course).exercise_ids
      @apps = current_course.students.includes(:apps).map(&:apps).flatten
    end
  end
end
