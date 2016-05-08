module Courses
  class Summer2016 < Base

    def self.exercises
      {
        1 => [ 0, Date.new(2016, 12, 12) ],
        2 => [ 2, Date.new(2016, 5, 6) ],
        3 => [ 4, Date.new(2016, 5, 9) ],
        4 => [ 2, Date.new(2016, 5, 16) ],
        5 => [ 4, Date.new(2016, 5, 23) ],
      }
    end

    def self.exercise_names
      {
        2 => 'http',
        3 => 'html',
        4 => 'ruby',
        5 => 'sinatra',
      }
    end

    def self.review_points
      {
        1 => (0..0),
        2 => (0..0),
        3 => (0..2),
        4 => (0..0),
        5 => (0..2),
      }
    end
  end
end
