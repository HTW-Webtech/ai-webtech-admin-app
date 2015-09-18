class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,    null: false
      t.string :username, null: false
      t.string :ssh_key
      t.text :env_vars
      t.string :pg_user
      t.string :pg_password

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
  end
end
