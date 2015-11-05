require 'securerandom'

class App < ActiveRecord::Base
  validates :user, presence: true
  belongs_to :user
  has_many :exercise_results

  serialize :env_vars, JSON

  def self.reviewed
    where.not(reviewed_at: nil)
  end

  def self.exercise_completed
    where.not(exercise_passed_at: nil)
  end

  def prefill(user)
    self.name        ||= AppName.generate_unique
    self.ssh_key     ||= user.ssh_key
    self.pg_database ||= self.name
    self.pg_login    ||= self.name
    self.pg_passwd   ||= SecureRandom.uuid
    self.env_vars    ||= { 'VARIABLE_NAME' => 'VALUE' }
    self.exercise_id ||= Exercise.generate_next_id(user)
    self
  end

  def reloading?
    File.exists? semaphore_file_path
  end

  def ready?
    !reloading?
  end

  def semaphore_file_path
    Rails.root + "tmp/#{name}-reloading"
  end

  def tests_passed?
    exercise_passed_at?
  end

  def total_points
    exercise_points + review_points
  end

  def exercise_points
    return 0 unless exercise_results.exists?
    result = exercise_results.where('created_at < ?', Exercise.deadline(exercise_id)).order(created_at: :desc).first!
    points = achievable_review_points - result.failures_count
    [points, 0].max
  end

  def achievable_total_points
    achievable_exercise_points + achievable_review_points
  end

  def achievable_exercise_points
    Exercise.points(exercise_id)
  end

  def review_points
    reviewed? ? achievable_review_points : 0
  end

  def achievable_review_points
    2
  end

  def reviewed?
    reviewed_at.present?
  end

  def fetch_logs
    @logs ||= AppLogTailer.fetch(self)
  end

  # TODO: Extract me
  def jenkins_url
    "http://#{cc(:site).jenkins_hostname}/job/#{exercise_id}-#{name}/"
  end

  def publish_to_app_service
    ArisService.publish(self)
  end

  def publish_to_jenkins_service
    JenkinsService.publish(self)
  end

  # TODO: Move in some view helper
  def view_git_clone_host
    "ssh://#{name}@#{cc(:site).git_hostname}/var/apps/#{name}/code"
  end

  def public_url
    "http://#{name}.#{cc(:site).hostname}"
  end
end
