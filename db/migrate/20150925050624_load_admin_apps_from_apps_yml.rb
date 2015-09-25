class LoadAdminAppsFromAppsYml < ActiveRecord::Migration
  # Move this into a generic feature?
  def up
    admin_app = ArisControl::Bookkeeper.new.apps['admin']
    App.create!({
      name: 'admin',
      user: User.admin,
      email: admin_app['email'],
      env_vars: admin_app['env_vars'],
      ssh_key: admin_app['ssh_key'],
      pg_database: admin_app['env_vars']['POSTGRES_DATABASE_NAME'],
      pg_login: admin_app['env_vars']['POSTGRES_LOGIN'],
      pg_passwd: admin_app['env_vars']['POSTGRES_PASSWORD'],
    })
  end

  def down
    App.where(name: 'admin').destroy_all
  end
end
