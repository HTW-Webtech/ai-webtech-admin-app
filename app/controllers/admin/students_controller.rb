module Admin
  class StudentsController < BaseController
    def show
      @students = current_course.students.includes(:apps)
      @exercise_ids = ExercisePointMaster.new(current_course).exercise_ids
    end
  end
end
