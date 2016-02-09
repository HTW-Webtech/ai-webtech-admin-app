class User < ActiveRecord::Base
  class Appraisal
    attr_accessor :user, :course

    def initialize(user, course: Courses.current)
      @user   = user
      @course = course
    end

    def percentage
      [ 100 * user.total_points.to_f/course.total_points.to_f, 100].min.round
    end

    GRADES = {
      (0...50) => 5.0,
      (50...55) => 4.0,
      (55...60) => 3.7,
      (60...65) => 3.3,
      (65...70) => 3.0,
      (70...75) => 2.7,
      (75...80) => 2.3,
      (80...85) => 2.0,
      (85...90) => 1.7,
      (90...95) => 1.3,
      (95..100) => 1.0,
    }

    def grade
      GRADES.detect { |range, _| range.include?(percentage) }.last
    end
  end
end
