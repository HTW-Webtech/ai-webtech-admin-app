class DropPostgressFeature < ActiveRecord::Migration
  def up
    remove_column :apps, :pg_host
    remove_column :apps, :pg_database
    remove_column :apps, :pg_login
    remove_column :apps, :pg_passwd
  end

  def down
    add_column :apps, :pg_host, :string, default: 'localhost'
    add_column :apps, :pg_database, :string
    add_column :apps, :pg_login, :string
    add_column :apps, :pg_passwd, :string
  end
end
