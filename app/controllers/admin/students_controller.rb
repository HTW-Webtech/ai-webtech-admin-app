module Admin
  class StudentsController < BaseController
    def show
      @students = User.includes(:apps).all
      @exercise_ids = Exercise.active_ids
    end
  end
end
