class CreateExerciseResults < ActiveRecord::Migration
  def change
    create_table :exercise_results do |t|
      t.integer :app_id,         null: false
      t.integer :exercise_id,    null: false
      t.integer :failures_count, null: false, default: -1

      t.timestamps null: false
    end
  end
end
