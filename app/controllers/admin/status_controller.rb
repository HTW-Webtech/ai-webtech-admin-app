module Admin
  class StatusController < BaseController
    def show
      @exercise_ids = App.distinct(:exercise_id).pluck(:exercise_id)
      @apps = App.all
    end
  end
end
