class AddReviewPoints < ActiveRecord::Migration
  def change
    add_column :apps, :review_points, :integer, default: 0, null: false
  end
end
