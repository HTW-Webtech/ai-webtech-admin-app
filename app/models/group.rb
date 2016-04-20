class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :groups_users

  def self.current_course
    where(name: Courses.current.display_name).first_or_create!
  end

  def display_name
    "#{name} (#{users.count})"
  end
end
