module Admin
  class FixturesController < BaseController
    def create
      id = User.count+1
      user = User.create({
        email: "#{id}-foo@htw-berlin.de",
        name: "#{id}-alice-or-bob",
        ssh_key: "ssh-rsa …",
        password: '123geheim',
        password_confirmation: '123geheim',
        confirmed_at: Time.now,
      })
      10.times do |i|
        app = App.new(user: user).prefill
        app.save!
        ArisService.publish(app)
      end
      redirect_to root_path, notice: "Created user: #{user.name} with 10 apps"
    end

    def create_yml
      App.all.each do |app|
        ArisService.publish(app)
      end
      redirect_to root_path, notice: 'Recreated the apps.yml file'
    end
  end
end
