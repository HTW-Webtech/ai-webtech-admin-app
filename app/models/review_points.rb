class ReviewPoints
  attr_accessor :course, :points

  def initialize(course = Courses.current)
    @course = course || Courses.current
    @points = @course.review_points
  end

  def for_app(app)
    points.fetch(app.exercise_id, (0..0))
  end

  def achievable(app)
    for_app(app).max
  end
end
