module Courses
  module Winter2015
    module_function

    EXERCISES = {
      1 => [ 2, Date.new(2015, 11, 27) ],
      2 => [ 2, Date.new(2015, 11, 24) ],
      3 => [ 4, Date.new(2015, 12, 14) ],
      4 => [ 2, Date.new(2016, 1, 11) ],
      5 => [ 0, Date.current ],
    }

    REVIEW_POINTS = {
      1 => (0..2),
      2 => (0..2),
      3 => (0..4),
      4 => (0..2),
      5 => (0..16),
    }

    def exercises
      EXERCISES
    end

    def review_points
      REVIEW_POINTS
    end
  end
end
