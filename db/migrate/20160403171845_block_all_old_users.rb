class BlockAllOldUsers < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE users SET
        blocked_at = '#{Time.current}'
      WHERE
        created_at < '2016-01-01 00:00'
        AND name != 'admin'
    SQL
  end

  def down
    execute <<-SQL
      UPDATE users SET
        blocked_at = NULL
      WHERE
        created_at < '2016-01-01 00:00'
    SQL
  end
end
