class ExercisePointMaster
  attr_accessor :course, :exercises, :messages

  def initialize(course = Courses.current)
    @course    = course || Courses.current
    @exercises = @course.exercises
    @messages = []
  end

  def evaluate!(exercise_result)
    if reached_deadline? exercise_result
      messages << "Deadline hit."
      messages << "Points: #{points(exercise_result)}"
      exercise_result.app.update_exercise_points(points(exercise_result))
    else
      messages << "Deadline missed."
      messages << "Deadline: #{deadline(exercise_result)}."
      messages << "Now: #{Time.now}."
    end
    message = messages.join(', ')
    Notifier.notify "Exercise-Result for App #{exercise_result.app.display_name}: #{message}"
    exercise_result.update message: message
    self
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

  def exercise_name(exercise_id)
    course.exercise_names.fetch(exercise_id, '')
  end

  def reached_deadline?(exercise_result)
    exercise_result.created_at < deadline(exercise_result)
  end

  # TODO: Use a better abstraction here
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
