class DropIndexFromAppNames < ActiveRecord::Migration
  def up
    remove_index :apps, :name
  end

  def down
    add_index "apps", ["name"], name: "index_apps_on_name", unique: true, using: :btree
  end
end
