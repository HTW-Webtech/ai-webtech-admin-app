module Courses
  class Summer2016 < Base

    def self.exercises
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

    # TODO: The Base class expects a certain data structure. FIXME
    def self.total_test_points
      0
    end
  end
end
