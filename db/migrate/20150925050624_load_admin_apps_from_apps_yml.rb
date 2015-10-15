class LoadAdminAppsFromAppsYml < ActiveRecord::Migration
  # Move this into a generic feature?
  def up
    app = App.new({
      name: cc(:admin).name,
      user: User.admin,
      env_vars: {},
      ssh_key: cc(:admin).pub_ssh_key,
      pg_database: admin,
      pg_login: admin,
      pg_passwd: ENV.fetch('POSTGRES_PASSWORD'),
    })
    app.save!
  end

  def down
    App.where(name: 'admin').destroy_all
  end
end
