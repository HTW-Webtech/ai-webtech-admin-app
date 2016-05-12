class ReviewDate < ActiveRecord::Base
  has_many :users, through: :review_group
  belongs_to :user
  belongs_to :review_group

  def self.upcoming_for_user(user)
    where('begins_at > ?', [Time.now]).where(review_group_id: user.review_group_id)
  end

  def presenter_display_name
    user.try(:display_name) || '-'
  end

  def formatted_begins_at
    begins_at.to_s(:long)
  end

  def confirm(points)
    users.each do |user|
      app = user.apps.where(exercise_id: exercise_id).first!
      app.update!(reviewed_at: Time.current, review_points: points)
    end
    update reviewed_at: Time.current, review_points: points
  end

  def revoke
    users.each do |user|
      app = user.apps.where(exercise_id: exercise_id).first!
      app.update!(reviewed_at: nil, review_points: 0)
    end
    update reviewed_at: nil, review_points: 0
  end

  def reviewed?
    reviewed_at.present?
  end
end
