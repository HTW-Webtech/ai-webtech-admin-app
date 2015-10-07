class Exercise
  POINTS = {
    1 => 2,
    2 => 4,
  }

  def self.generate_next_id(user)
    user.app_count + 1
  end

  def self.points(exercise_id)
    POINTS.fetch(exercise_id, 0)
  end
end
