class AddLengthToReviewDate < ActiveRecord::Migration
  def change
    add_column :review_dates, :length_in_minutes, :integer, null: false, default: 10
  end
end
