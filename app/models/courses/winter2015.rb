module Courses
  class Winter2015 < Base
    class << self
      def exercises
        {
          1 => [ 2, Date.new(2015, 11, 27) ],
          2 => [ 2, Date.new(2015, 11, 24) ],
          3 => [ 4, Date.new(2015, 12, 14) ],
          4 => [ 2, Date.new(2016, 1, 12) ],
          5 => [ 0, Date.current ],
        }
      end

      def review_points
        {
          1 => (0..2),
          2 => (0..2),
          3 => (0..4),
          4 => (0..0),
          5 => (0..18),
        }
      end
    end
  end
end
