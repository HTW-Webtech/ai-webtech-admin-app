class User < ActiveRecord::Base
  module AppLimit
    module_function

    def limit_reached?(user, course = Courses.current)
      return false if user.admin?
      # TODO: Attach course to the user!
      user.apps.count >= course.exercises.count
    end
  end
end
