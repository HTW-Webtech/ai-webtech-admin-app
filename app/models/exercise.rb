class Exercise
  DEADLINES = {
    1 => Date.new(2015, 10, 26)
  }
  POINTS = {
    1 => 2,
    2 => 4,
  }

  def self.active_ids
    App.distinct(:exercise_id).pluck(:exercise_id).sort
  end

  def self.generate_next_id(user)
    user.app_count + 1
  end

  def self.points(exercise_id)
    POINTS.fetch(exercise_id, 0)
  end

  def self.deadline(exercise_id)
    DEADLINES.fetch(exercise_id, Date.new(2017, 01, 01))
  end
end
