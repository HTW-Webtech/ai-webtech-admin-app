class MigrateReviewDateMarkers < ActiveRecord::Migration
  def up
    ReviewDate.find_each do |review_date|
      review_date.user_id or next
      user = User.find(review_date.user_id)
      user.update reviewed_at: review_date.reviewed_at
    end
  end

  def down
  end
end
