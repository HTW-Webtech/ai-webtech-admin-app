class AddReviewMarkerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reviewed_at, :datetime
  end
end
