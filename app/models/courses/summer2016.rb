module Courses
  class Summer2016 < Base

    def self.exercises
      {
        1 => [ 0, Date.new(2016, 12, 12) ],
        2 => [ 2, Date.new(2016, 5, 6) ],
        3 => [ 2, Date.new(2016, 5, 11) ],
        4 => [ 2, Date.new(2016, 5, 16) ],
        5 => [ 4, Date.new(2016, 5, 30) ],
        6 => [ 8, Date.new(2016, 6, 12) ],
      }
    end

    def self.exercise_names
      {
        2 => 'http',
        3 => 'html',
        4 => 'ruby',
        5 => 'sinatra',
        6 => 'datamapper',
      }
    end

    def self.review_points
      {
        1 => (0..0),
        2 => (0..0),
        3 => (0..2),
        4 => (0..0),
        5 => (0..4),
        6 => (0..6),
      }
    end
  end
end
