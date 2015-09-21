class AddUserToApps < ActiveRecord::Migration
  def change
    # TODO: Foreign key?
    add_column :apps, :user_id, :integer, null: false
  end
end
