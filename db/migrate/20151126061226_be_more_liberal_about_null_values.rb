class BeMoreLiberalAboutNullValues < ActiveRecord::Migration
  def up
    change_column :apps, :ssh_key, :string, null: true
    change_column :apps, :pg_host, :string, null: true
    change_column :apps, :pg_database, :string, null: true
    change_column :apps, :pg_login, :string, null: true
    change_column :apps, :pg_passwd, :string, null: true

    change_column :apps, :exercise_id, :integer, null: true
  end

  def down
    change_column :apps, :ssh_key, :string, null: false
    change_column :apps, :pg_host, :string, null: false
    change_column :apps, :pg_database, :string, null: false
    change_column :apps, :pg_login, :string, null: false
    change_column :apps, :pg_passwd, :string, null: false

    change_column :apps, :exercise_id, :integer, null: false
  end
end
