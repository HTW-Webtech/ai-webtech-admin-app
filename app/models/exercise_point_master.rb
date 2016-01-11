class ExercisePointMaster
  EXERCISES = {
    1 => [ 2, Date.new(2015, 11, 27) ],
    2 => [ 2, Date.new(2015, 11, 24) ],
    3 => [ 4, Date.new(2015, 12, 14) ],
    4 => [ 2, Date.new(2016, 1, 11) ],
    5 => [ 0, Date.current ],
  }

  def self.evaluate_app!(app)
    # TODO: Skip results after deadline
    ExerciseResult.where(app: app, exercise_id: exercise_ids).find_each do |result|
      evaluate!(result)
    end
  end

  def self.exercise_ids
    EXERCISES.keys
  end

  def self.evaluate!(exercise_result)
    if reached_deadline? exercise_result
      !!exercise_result.app.update(exercise_points: points(exercise_result))
    else
      false
    end
  end

  def self.reached_deadline?(exercise_result)
    exercise_result.created_at < deadline(exercise_result)
  end

  def self.deadline(exercise_result)
    EXERCISES.fetch(exercise_result.exercise_id, [1.day.ago]).last
  end

  def self.points(exercise_result)
    points_for_exercise(exercise_result.exercise_id)
  end

  def self.points_for_exercise(exercise_id)
    EXERCISES.fetch(exercise_id, [0]).first
  end
end
