# Point-Overview for all students
# students.each do |student|
#   points["exercises"]["1"]["students"][student.id]["total_points"] => 6
#   points["exercises"]["1"]["students"][student.id]["review_points"] => 2
#   points["exercises"]["1"]["students"][student.id]["test_points"] => 4
# end
#
# {
#   "exercises" => {
#     "1" => {
#       "students" => {
#         "1" => {
#           "total_points" => 6,
#           "review_points" => 2,
#           "test_points" => 4
#         },
#         "2" => {
#           "total_points" => 4,
#           "review_points" => 0,
#           "test_points" => 4
#         }
#       }
#     }
#   }
# }
module Statistics
  class StudentsPoints
    attr_accessor :students

    def initialize(students)
      @students = students
    end

    def to_json
      data.to_json
    end

    def data
      @data ||= begin
                  exercise_ids.each_with_object({}) do |exercise_id, h|
                    h['exercises'] ||= {}
                    h['exercises'][exercise_id] = students_points(exercise_id)
                  end
                end
    end

    def students_points(exercise_id)
      students.each_with_object({}) do |student, h|
        sh = h['students'] = {}
        app = student.apps.detect { |app| app.exercise_id == exercise_id } || App.new
        sh[student.id] = {
          "total_points"    => app.total_points,
          "review_points"   => app.review_points,
          "exercise_points" => app.exercise_points
        }
      end
    end

    def exercise_ids
      ExercisePointMaster.exercise_ids
    end
  end
end
