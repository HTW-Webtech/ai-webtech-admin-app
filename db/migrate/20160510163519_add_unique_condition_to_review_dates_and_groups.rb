class AddUniqueConditionToReviewDatesAndGroups < ActiveRecord::Migration
  def change
    add_index :review_dates, [:review_group_id, :exercise_id], unique: true
  end
end
