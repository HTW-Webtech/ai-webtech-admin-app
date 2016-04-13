module Courses
  module Summer2016
    include Base
    module_function

    def exercises
      {
        2 => {
          points: {
            tests: 0,
            review: (0..2)
          },
          # TODO: Fix Deadline
          deadline: Date.new(2016, 4, 24)
        },
      }
    end

    def review_points
      {
      }
    end
  end
end
