class AddSummer2016Group < ActiveRecord::Migration
  def up
    ss2016 = Group.create(name: 'SS2016')
    User.where('created_at > ?', [3.weeks.ago]).each do |user|
      ss2016.users << user
    end
  end

  def down
    Group.where(name: 'SS2016').delete_all
  end
end
