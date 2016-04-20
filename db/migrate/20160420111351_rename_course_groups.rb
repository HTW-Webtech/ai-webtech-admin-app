class RenameCourseGroups < ActiveRecord::Migration
  def up
    Group.where(name: 'SS2016').update_all(name: 'Summer2016')
    Group.where(name: 'WS2015').update_all(name: 'Winter2015')
  end

  def down
    Group.where(name: 'Summer2016').update_all(name: 'SS2016')
    Group.where(name: 'Winter2015').update_all(name: 'WS2015')
  end
end
