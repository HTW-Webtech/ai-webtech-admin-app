class AddAdminUser < ActiveRecord::Migration
  def up
    User.create!({
      email:                 cc(:admin).email,
      name:                  cc(:admin).name,
      ssh_key:               cc(:admin).pub_ssh_key,
      password:              ENV.fetch('ADMIN_PASSWORD'),
      password_confirmation: ENV.fetch('ADMIN_PASSWORD'),
    })
  end

  def down
    User.where(name: cc(:admin).name).destroy_all
  end
end
