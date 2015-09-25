class AddAdminUser < ActiveRecord::Migration
  def up
    User.create!({
      email:                 ENV['ADMIN_EMAIL'],
      name:                  'admin',
      ssh_key:               ENV['ADMIN_PUB_SSH_KEY'],
      password:              ENV['ADMIN_PASSWORD'],
      password_confirmation: ENV['ADMIN_PASSWORD']
    })
  end

  def down
    User.where(name: 'admin').destroy_all
  end
end
