class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :email, null: false
      t.string :name,  null: false
      t.string :ssh_key
      t.text :env_vars

      t.timestamps null: false
    end

    add_index :apps, :name, unique: true
  end
end
