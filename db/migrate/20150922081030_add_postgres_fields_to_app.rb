class AddPostgresFieldsToApp < ActiveRecord::Migration
  def change
    add_column :apps, :pg_host, :string, default: 'localhost', null: false
    add_column :apps, :pg_database, :string, default: '', null: false
    add_column :apps, :pg_login, :string, default: '', null: false
    add_column :apps, :pg_passwd, :string, default: '', null: false
  end
end
