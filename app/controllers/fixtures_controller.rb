class FixturesController < ApplicationController
  before_action :only_admin_allowed

  def create
    id = User.count+1
    user = User.create({
      email: "#{id}-foo@example.com",
      name: "#{id}-alice-or-bob",
      ssh_key: "ssh-rsa …",
      password: '123geheim',
      password_confirmation: '123geheim',
    })
    10.times do |i|
      app = App.new(user: user)
      app.save!
      Aris.publish(app)
    end
    redirect_to root_path, notice: "Created user: #{user.name} with 10 apps"
  end

  def create_yml
    App.all do |app|
      Aris.publish(app)
    end
    redirect_to root_path, notice: 'Recreated the apps.yml file'
  end

  private

  def only_admin_allowed
    current_user.admin?
  end
end
