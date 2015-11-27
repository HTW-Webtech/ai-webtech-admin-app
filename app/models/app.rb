require 'securerandom'

class App < ActiveRecord::Base
  validates :user, presence: true
  belongs_to :user
  has_many :exercise_results

  serialize :env_vars, JSON

  def self.for_permalink_or_id(permalink_or_id)
    id = permalink_or_id.to_s.split('-').first
    find(id)
  end

  def self.reviewed
    where.not(reviewed_at: nil)
  end

  def self.exercise_completed
    where('exercise_points > ?', 0)
  end

  # TODO: remove user dependency
  def prefill
    self.name        ||= AppName.generate_unique
    self.ssh_key     ||= user.ssh_key if user
    self.env_vars    ||= Hash.new
    self.exercise_id ||= Exercise.generate_next_id(user)
    self
  end

  def permalink
    "#{id}-#{name}"
  end

  def reloading?
    File.exists? semaphore_file_path
  end

  def ready?
    !reloading?
  end

  def semaphore_file_path
    Rails.root + "tmp/#{permalink}-reloading"
  end

  def tests_passed?
    exercise_points > 0
  end

  def total_points
    exercise_points + review_points
  end

  def achievable_total_points
    achievable_exercise_points + achievable_review_points
  end

  def achievable_exercise_points
    ExercisePointMaster.points_for_exercise(exercise_id)
  end

  def achievable_review_points
    ReviewPoints.achievable(self)
  end

  def reviewed?
    reviewed_at.present?
  end

  def fetch_logs
    @logs ||= AppLogTailer.fetch(self)
  end

  # TODO: Extract me
  def jenkins_url
    "http://#{cc(:site).jenkins_hostname}/job/#{exercise_id}-#{permalink}/"
  end

  def publish_to_app_service
    ArisService.publish(self)
  end

  def publish_to_jenkins_service
    JenkinsService.publish(self)
  end

  # TODO: Move in some view helper
  def view_git_clone_host
    "ssh://#{permalink}@#{cc(:site).git_hostname}/var/apps/#{permalink}/code"
  end

  def public_url
    "http://#{permalink}.#{cc(:site).hostname}"
  end
end
