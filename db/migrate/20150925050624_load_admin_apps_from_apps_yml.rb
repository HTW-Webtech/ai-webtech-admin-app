class LoadAdminAppsFromAppsYml < ActiveRecord::Migration
  # Move this into a generic feature?
  require 'byebug'
  def up
    admin_app = ArisControl::Bookkeeper.new.apps['admin']
    app = App.create!({
      name: 'admin',
      user: User.admin,
      email: admin_app['email'],
      env_vars: admin_app['env_vars'],
      ssh_key: admin_app['ssh_key'],
      pg_database: admin_app['env_vars']['PG_DB'],
      pg_login: admin_app['env_vars']['PG_USER'],
      pg_passwd: admin_app['env_vars']['PG_PASSWORD'],
    })
    app.update_column(:env_vars_view, 'Managed by ansible!')
  end

  def down
    App.where(name: 'admin').destroy_all
  end
end
