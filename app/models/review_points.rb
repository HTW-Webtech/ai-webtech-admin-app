class ReviewPoints
  POINTS = {
    1 => (0..2),
    2 => (0..2),
    3 => (2..4),
  }

  def self.for(app)
    POINTS.fetch(app.exercise_id)
  end

  def self.achievable(app)
    self.for(app).max
  end
end
