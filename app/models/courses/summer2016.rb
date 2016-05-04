module Courses
  class Summer2016 < Base

    def self.exercises
      {
        1 => [ 0, Date.new(2016, 12, 12) ],
        2 => [ 2, Date.new(2016, 5, 4) ], # TODO: Deadline moved to 4th of May
        3 => [ 4, Date.new(2016, 5, 8) ],
        4 => [ 2, Date.new(2016, 5, 15) ],
      }
    end

    def self.exercise_names
      {
        2 => 'http',
        3 => 'html',
        4 => 'ruby',
      }
    end

    def self.review_points
      {
        1 => (0..0),
        2 => (0..0),
        3 => (0..2),
        4 => (0..0),
      }
    end
  end
end
