class ReviewDate < ActiveRecord::Base
  has_many :users, through: :review_group
  belongs_to :user
  belongs_to :review_group

  def self.upcoming_for_user(user)
    where('begins_at > ?', [Time.now]).where(review_group_id: user.review_group_id)
  end

  def self.past
    where('begins_at < ?', [1.day.from_now]).order(begins_at: :asc)
  end

  def self.upcoming
    where('begins_at > ?', [1.day.ago]).order(begins_at: :asc)
  end

  def self.without_review
    where(reviewed_at: nil)
  end

  def user_apps
    App.where(user: users, exercise_id: exercise_id)
  end

  def presenter_display_name
    user.try(:display_name) || '-'
  end

  def formatted_reviewed_at
    if reviewed?
      reviewed_at.to_s(:long)
    else
      "-"
    end
  end

  def formatted_begins_at
    begins_at.to_s(:long)
  end

  def confirm(points, user_id)
    users.each do |user|
      if app = user.apps.where(exercise_id: exercise_id).first
        app.update!(reviewed_at: Time.current, review_points: points)
      end
    end
    update reviewed_at: Time.current, review_points: points
    update user_id: user_id
    Email::CodeReviewConfirmationMailer.new(self).run
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
