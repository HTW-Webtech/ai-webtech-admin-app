class RemoveAppIdFromName < ActiveRecord::Migration
  class App < ActiveRecord::Base
  end

  def change
    App.find_each do |app|
      next unless !!app.name(/\d+-\w+/)
      app.update! name: app.name.match(/\d-(.+)/)[1]
    end
  end
end
