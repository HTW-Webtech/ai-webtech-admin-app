class AddCourseToUser < ActiveRecord::Migration
  def up
    add_column :users, :course, :string
    %w(Summer2016 Winter2015).each do |course|
      group = Group.where(name: course).first!
      group.users.each do |user|
        user.update course: course
      end
    end
  end

  def down
    remove_column :users, :course
  end
end
