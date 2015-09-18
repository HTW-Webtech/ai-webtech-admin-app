class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :ssh_key
      t.text :env_vars
      t.string :pg_user
      t.string :pg_password

      t.timestamps null: false
    end
  end
end
