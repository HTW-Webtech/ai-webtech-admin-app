module Courses
  class Base
    def self.exercises
      { 1 => [ 2, Date.current ] }
    end

    def self.display_name
      name.demodulize
    end

    def self.review_points
      { 1 => (0..5) }
    end

    def self.total_test_points
      exercises.values.sum(&:first)
    end

    def self.total_review_points
      review_points.values.sum(&:max)
    end

    def self.total_points
      total_test_points + total_review_points
    end
  end
end

require 'courses/winter2015'
require 'courses/summer2016'
