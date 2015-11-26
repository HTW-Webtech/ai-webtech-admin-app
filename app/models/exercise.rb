class Exercise

  def self.active_ids
    App.distinct(:exercise_id).pluck(:exercise_id).sort
  end

  def self.generate_next_id(user)
    user.app_count + 1
  end
end
