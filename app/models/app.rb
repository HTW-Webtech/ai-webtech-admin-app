require 'securerandom'

class App < ActiveRecord::Base
  validates :user, presence: true
  belongs_to :user
  has_many :exercise_results

  def self.for_permalink_or_id(permalink_or_id)
    id = permalink_or_id.to_s.split('-').first
    find(id)
  end

  def self.reviewed
    where.not(reviewed_at: nil)
  end

  # TODO: remove user dependency
  def prefill
    self.name        ||= AppName.generate_unique
    self.ssh_key     ||= user.ssh_key if user
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

  def update_exercise_points(points)
    if exercise_points < 1
      Email::AppPointsMailer.new(app: self, points: points).run
    end
    update exercise_points: points
  end

  def semaphore_file_path
    Rails.root + "tmp/#{permalink}-reloading"
  end

  def exercise_name
    ExercisePointMaster.new(course).exercise_name(exercise_id)
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
    ExercisePointMaster.new(course).points_for_exercise(exercise_id)
  end

  def achievable_review_points
    ReviewPoints.new(course).achievable(self)
  end

  def course
    if user
      "Courses::#{user.course}".constantize
    end
  end

  def reviewed?
    reviewed_at.present?
  end

  def fetch_logs
    @logs ||= AppLogTailer.fetch(self)
  end

  # TODO: Extract me
  def jenkins_url
    "http://#{cc(:site).jenkins_hostname}/job/#{permalink}/"
  end

  def testing_url
    if external_hosting?
      external_url || jenkins_url
    end
  end

  def git_webview_url
    "http://#{cc(:site).git_webview_hostname}/#{permalink}/commits/master"
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
    "http://#{permalink}.#{cc(:site).app_hostname}"
  end
end
