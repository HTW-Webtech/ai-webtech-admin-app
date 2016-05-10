class ReviewPoints
  attr_accessor :course, :points

  def initialize(course = Courses.current)
    @course = course || Courses.current
    @points = @course.review_points
  end

  def for_app(app)
    for_exercise_id(app.exercise_id)
  end

  def for_exercise_id(exercise_id)
    points.fetch(exercise_id, (0..0))
  end

  def achievable(app)
    for_app(app).max
  end
end
