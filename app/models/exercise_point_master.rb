class ExercisePointMaster
  attr_accessor :course, :exercises

  def initialize(course = Courses.current)
    @course    = course
    @exercises = course.exercises
  end

  def evaluate_app!(app)
    # TODO: Skip results after deadline
    ExerciseResult.where(app: app, exercise_id: exercise_ids).find_each do |result|
      evaluate!(result)
    end
  end

  def exercise_ids
    exercises.keys
  end

  def evaluate!(exercise_result)
    if reached_deadline? exercise_result
      !!exercise_result.app.update(exercise_points: points(exercise_result))
    else
      false
    end
  end

  def reached_deadline?(exercise_result)
    exercise_result.created_at < deadline(exercise_result)
  end

  def deadline(exercise_result)
    exercises.fetch(exercise_result.exercise_id, [1.day.ago]).last
  end

  def points(exercise_result)
    points_for_exercise(exercise_result.exercise_id)
  end

  def points_for_exercise(exercise_id)
    exercises.fetch(exercise_id, [0]).first
  end
end
