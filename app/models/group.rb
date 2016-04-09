class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :groups_users

  def display_name
    "#{name} (#{users.count})"
  end
end
