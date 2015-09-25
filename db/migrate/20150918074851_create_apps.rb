class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,        null: false
      t.string :email,       null: false
      t.string :ssh_key,     null: false, default: ''

      t.string :pg_host,     :string, default: 'localhost', null: false
      t.string :pg_database, :string, default: '', null: false
      t.string :pg_login,    :string, default: '', null: false
      t.string :pg_passwd,   :string, default: '', null: false

      t.text :env_vars
      t.text :env_vars_view, null: false, default: ''

      t.integer :user_id,    null: false
      t.timestamps null: false
    end

    add_index :apps, :name, unique: true
  end
end
