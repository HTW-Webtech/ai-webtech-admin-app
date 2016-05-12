class AddReviewUserToReviewDate < ActiveRecord::Migration
  def change
    add_column :review_dates, :user_id, :integer
  end
end
