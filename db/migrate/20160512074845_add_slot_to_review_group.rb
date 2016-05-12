class AddSlotToReviewGroup < ActiveRecord::Migration
  def change
    add_column :review_groups, :order, :integer, default: 0, null: false
  end
end
