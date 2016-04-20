module Admin
  class StatisticsController < BaseController
    def show
      @google_chart_data = Statistics::OverallPoints.new(current_course.students).google_chart_data
    end
  end
end
