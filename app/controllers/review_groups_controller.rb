class ReviewGroupsController < ::BaseController
  def show
    @review_group = current_user.review_group
  end
end
