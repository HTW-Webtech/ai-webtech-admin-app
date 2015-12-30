module Admin
  class StatisticsController < BaseController
    def show
      @google_chart_data = Statistics::OverallPoints.new.google_chart_data
    end
  end
end
