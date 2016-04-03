class PrefillTimestampColumnsForUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE users SET
        created_at = '2015-10-01 12:00:00',
        updated_at = '2015-10-01 12:00:00'
    SQL

    change_column :users, :created_at, :datetime, null: false
    change_column :users, :updated_at, :datetime, null: false
  end

  def down
    change_column :users, :created_at, :datetime, null: true
    change_column :users, :updated_at, :datetime, null: true

    execute <<-SQL
      UPDATE users SET
        created_at = NULL,
        updated_at = NULL
    SQL
  end
end
