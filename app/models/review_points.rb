class ReviewPoints
  POINTS = {
    1 => (0..2),
    2 => (0..2),
    3 => (2..4),
  }

  def self.for_app(app)
    POINTS.fetch(app.exercise_id, (0..0))
  end

  def self.achievable(app)
    for_app(app).max
  end
end
