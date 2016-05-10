module Courses
  class Base
    def self.exercises
      { 1 => [ 2, Date.current ] }
    end

    def self.exercise_names_with_review
      ids = review_points.select { |_, points| points.max > 0 }.map(&:first)
      exercise_names.select { |exercise_id, _| ids.include?(exercise_id) }
    end

    def self.apps
      App.where(course: display_name)
    end

    def self.display_name
      name.demodulize
    end

    def self.students
      Group.where(name: display_name).first.users
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
