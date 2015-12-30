# Overall points
# students.each do |student|
#   student["user"] => User(email: …),
#   student["total_points"] => 6
# end
module Statistics
  class OverallPoints
    attr_accessor :students

    def initialize(students = User.without_admin)
      @students = students
    end

    def google_chart_data
      formatted_data_with_header.to_json.html_safe
    end

    def formatted_data_with_header
      [['Student', 'Punkte']] + formatted_data
    end

    def formatted_data
      data.map { |result| [result['user']['email'], result['points']] }
    end

    def data
      students.map do |student|
        {
          'user'   => student,
          'points' => sum_of_points(student)
        }
      end
    end

    def sum_of_points(student)
      student.apps.inject(0) { |sum, app| sum += app.total_points }
    end
  end
end
