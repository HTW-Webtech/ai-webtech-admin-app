class AddAdminUser < ActiveRecord::Migration
  def up
    User.create!({
      email:                 ENV['APP_ADMIN_EMAIL'],
      name:                  'admin',
      password:              ENV['APP_ADMIN_PASSWORD'],
      password_confirmation: ENV['APP_ADMIN_PASSWORD']
    })
  end

  def down
    User.where(username: 'admin').destroy_all
  end
end
