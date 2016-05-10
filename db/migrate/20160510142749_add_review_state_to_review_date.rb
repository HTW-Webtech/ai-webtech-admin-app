class AddReviewStateToReviewDate < ActiveRecord::Migration
  def change
    add_column :review_dates, :reviewed_at, :datetime
    add_column :review_dates, :review_points, :integer, default: 0, null: false
  end
end
