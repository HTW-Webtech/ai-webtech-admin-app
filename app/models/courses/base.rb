module Courses
  # TODO: Use Module instead of class
  class Base
    class << self
      def exercises
        { 1 => [ 2, Date.current ] }
      end

      def review_points
        { 1 => (0..5) }
      end

      def total_test_points
        exercises.values.sum(&:first)
      end

      def total_review_points
        review_points.values.sum(&:max)
      end

      def total_points
        total_test_points + total_review_points
      end
    end
  end
end
