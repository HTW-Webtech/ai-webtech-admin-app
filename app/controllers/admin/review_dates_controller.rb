module Admin
  class ReviewDatesController < BaseController
    def new
    end

    def create
      dates = review_dates.each &:save
      redirect_to :back, notice: "Created #{dates.count} new Review Dates."
    end

    private

    def review_dates
      begins_at = start_time
      groups_without_review_date.map do |group|
        ReviewDate.new(review_group: group, exercise_id: exercise_id, begins_at: begins_at).tap do
          begins_at += length_in_minutes.minutes
        end
      end
    end

    def groups_without_review_date
      ReviewGroup.limit(groups_limit).without_date_for_exercise(exercise_id)
    end

    def start_time
      Time.new(date_year, date_month, date_day, date_hour, date_minutes)
    end

    def date_year
      params[:review_date]['date(1i)'].to_i
    end

    def date_month
      params[:review_date]['date(2i)'].to_i
    end

    def date_day
      params[:review_date]['date(3i)'].to_i
    end

    def date_hour
      params[:review_date]['start_time(4i)'].to_i
    end

    def date_minutes
      params[:review_date]['start_time(5i)'].to_i
    end

    def groups_limit
      params[:review_date][:group_count].to_i
    end

    def exercise_id
      params[:review_date][:exercise_id].to_i
    end

    def length_in_minutes
      params[:review_date][:length_in_minutes].to_i
    end
  end
end
