module Courses
  class Summer2016 < Base
    class << self
      def exercises
        {
          2: {
            points: {
              tests: 0,
              review: (0..2)
            },
            # TODO: Fix Deadline
            deadline: Date.new(2016, 4, 24)
          },
        }
      end
    end
  end
end
