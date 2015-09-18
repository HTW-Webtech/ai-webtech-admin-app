class AddAdminUser < ActiveRecord::Migration
  def up
    User.create!({
      email:                 ENV['ARIS_ADMIN_EMAIL'],
      username:              'admin',
      password:              ENV['ARIS_ADMIN_PASSWORD'],
      password_confirmation: ENV['ARIS_ADMIN_PASSWORD']
    })
  end

  def down
    User.where(username: 'admin').destroy
  end
end
