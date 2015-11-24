class ReplaceExercisePassedOnAppsWithPoints < ActiveRecord::Migration
  def up
    remove_column :apps, :exercise_passed_at
    add_column :apps, :exercise_points, :integer, default: 0
  end

  def down
    add_column :apps, :exercise_passed_at, :datetime
    remove_column :apps, :exercise_points
  end
end
