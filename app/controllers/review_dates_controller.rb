class ReviewDatesController < ::BaseController
  before_action :load_review_date
  before_action :check_privileges

  def cancel
    @review_date.destroy!
    redirect_to :back, notice: "Der Code Review Termin wurde gelöscht!"
  end

  private

  def load_review_date
    @review_date = ReviewDate.find(params[:id])
  end

  def check_privileges
    @review_date.users.include? current_user
  end
end
