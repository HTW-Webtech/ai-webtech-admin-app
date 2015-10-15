class LoadAdminAppsFromAppsYml < ActiveRecord::Migration
  # Move this into a generic feature?
  def up
    app = App.new({
      name: 'admin',
      user: User.admin,
      env_vars: {},
      ssh_key: ENV.fetch('ADMIN_APP_PUB_SSH_KEY'),
      pg_database: ENV.fetch('ADMIN_APP_POSTGRES_DATABASE_NAME'),
      pg_login: ENV.fetch('ADMIN_APP_POSTGRES_LOGIN'),
      pg_passwd: ENV.fetch('ADMIN_APP_POSTGRES_PASSWORD'),
    })
    app.save!
  end

  def down
    App.where(name: 'admin').destroy_all
  end
end
