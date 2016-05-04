class AddCourseToApp < ActiveRecord::Migration
  def up
    add_column :apps, :course, :string
    App.includes(:user).find_each do |app|
      app.update course: app.user.course
    end
    change_column :apps, :course, :string, null: false
  end

  def down
    remove_column :apps, :course, :string
  end
end
