class AddUserToApps < ActiveRecord::Migration
  def change
    add_column :apps, :user_id, :integer, null: false
  end
end
