class AddAdminUser < ActiveRecord::Migration
  def up
    User.create!({
      email:                 ENV.fetch('ADMIN_EMAIL'),
      name:                  'admin',
      ssh_key:               ENV.fetch('ADMIN_PUB_SSH_KEY'),
      password:              ENV.fetch('ADMIN_PASSWORD'),
      password_confirmation: ENV.fetch('ADMIN_PASSWORD'),
    })
  end

  def down
    User.where(name: 'admin').destroy_all
  end
end
