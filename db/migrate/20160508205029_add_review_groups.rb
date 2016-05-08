class AddReviewGroups < ActiveRecord::Migration
  def change
    create_table :review_groups do |t|
      t.timestamps
    end

    create_table :review_dates do |t|
      t.integer :review_group_id, null: false
      t.datetime :begins_at, null: false
      t.integer :exercise_id, null: false
      t.timestamps
    end

    add_column :users, :review_group_id, :integer
  end
end
