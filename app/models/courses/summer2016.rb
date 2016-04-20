module Courses
  class Summer2016 < Base

    def self.exercises
      {
        1 => [ 0, Date.new(2016, 12, 12) ],
        2 => [ 2, Date.new(2016, 4, 26) ]
      }
    end

    def self.review_points
      {
        1 => (0..0),
        2 => (0..0),
      }
    end
  end
end
