class FixWinterCourseUser < ActiveRecord::Migration
  def up
    winter = Group.where(name: 'Winter2015').first
    winter.users = User.where('created_at < ?', [10.weeks.ago])
  end

  def down
    # noop
  end
end
