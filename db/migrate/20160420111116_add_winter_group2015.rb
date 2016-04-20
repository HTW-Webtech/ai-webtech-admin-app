class AddWinterGroup2015 < ActiveRecord::Migration
  def up
    ws2015 = Group.create(name: 'WS2015')
    User.where('created_at > ?', [8.weeks.ago]).each do |user|
      ws2015.users << user
    end
  end

  def down
    Group.where(name: 'WS2015').delete_all
  end
end
