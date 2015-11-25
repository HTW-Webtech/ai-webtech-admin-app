class RemoveAppIdFromName < ActiveRecord::Migration
  class App < ActiveRecord::Base
  end

  def up
    remove_index :apps, :name

    App.find_each do |app|
      next unless !!app.name.match(/\d+-\w+/)
      app.update! name: app.name.match(/\d-(.+)/)[1]
    end
  end

  def down
    add_index :apps, :name, unique: true
  end
end
