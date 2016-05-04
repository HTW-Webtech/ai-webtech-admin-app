class AddMessageToExerciseResult < ActiveRecord::Migration
  def change
    add_column :exercise_results, :message, :string
  end
end
