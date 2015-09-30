class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,        null: false
      t.string :email,       null: false
      t.string :ssh_key,     null: false

      t.string :pg_host,     default: 'localhost', null: false
      t.string :pg_database, null: false
      t.string :pg_login,    null: false
      t.string :pg_passwd,   null: false

      t.text :env_vars

      t.integer :user_id,    null: false
      t.timestamps null: false
    end

    add_index :apps, :name, unique: true
  end
end
