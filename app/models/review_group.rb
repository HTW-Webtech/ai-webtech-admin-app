class ReviewGroup < ActiveRecord::Base
  has_many :users
  has_many :review_dates

  def self.without_date_for_exercise(exercise_id)
    groups_with_date_ids = includes(:review_dates).where(review_dates: { exercise_id: exercise_id }).pluck(:id)
    where.not(id: groups_with_date_ids)
  end
end
