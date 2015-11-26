class MigrateAlreadyReviewedApps < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE apps
        SET review_points = 2
        WHERE reviewed_at IS NOT NULL
    SQL
  end

  def down
    execute <<-SQL
      UPDATE apps SET review_points = 0
    SQL
  end
end
