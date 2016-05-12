class ReviewGroupsController < ::BaseController
  def show
    @review_group = current_user.review_group
  end

  def update
    review_group = current_user.review_group
    review_group.update review_group_params
    redirect_to :back, notice: 'Einstellungen aktualisiert'
  end

  private

  def review_group_params
    params.require(:review_group).permit(:order)
  end
end
