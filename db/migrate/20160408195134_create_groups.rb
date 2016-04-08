class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
    end

    create_table :groups_users do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
    end
  end
end
