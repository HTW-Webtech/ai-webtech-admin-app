class User < ActiveRecord::Base
  module AppLimit
    module_function

    def limit_reached?(user)
      return false if user.admin?
      return true unless user.course
      user.apps.count >= user.course.exercises.count
    end
  end
end
