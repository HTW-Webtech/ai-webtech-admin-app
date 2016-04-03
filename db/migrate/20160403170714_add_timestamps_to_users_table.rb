class AddTimestampsToUsersTable < ActiveRecord::Migration
  def up
    add_timestamps :users
  end

  def down
    remove_timestamps :users
  end
end
