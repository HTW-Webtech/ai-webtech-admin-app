class DropFailuresCountOnResults < ActiveRecord::Migration
  def up
    remove_column :exercise_results, :failures_count
  end

  def down
    add_column :exercise_results, :failures_count, :integer, null: false, default: -1
  end
end
