class ReviewDate < ActiveRecord::Base
  belongs_to :review_group

  def self.upcoming_for_user(user)
    where('begins_at > ?', [Time.now]).where(review_group_id: user.review_group_id)
  end
end
