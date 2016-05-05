module Courses
  class Summer2016 < Base

    def self.exercises
      {
        1 => [ 0, Date.new(2016, 12, 12) ],
        2 => [ 2, Date.new(2016, 5, 6) ],
        3 => [ 4, Date.new(2016, 5, 9) ],
        4 => [ 2, Date.new(2016, 5, 16) ],
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
