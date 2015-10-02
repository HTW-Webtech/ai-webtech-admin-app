require 'securerandom'

class App < ActiveRecord::Base
  validates :user, presence: true
  belongs_to :user

  serialize :env_vars, JSON

  after_save :publish_to_app_service
  after_save :publish_to_jenkins_service

  after_initialize do
    if self.new_record?
      self.name        ||= AppName.generate_unique
      self.ssh_key     ||= user.ssh_key
      self.pg_database ||= self.name
      self.pg_login    ||= self.name
      self.pg_passwd   ||= SecureRandom.uuid
      self.env_vars    ||= { 'FOO' => 'BAR' }
      self.exercise_id ||= Exercise.generate_next_id(user)
    end
  end

  def is_active?
    true
  end

  def fetch_logs
    @logs ||= AppLogTailer.fetch(self)
  end

  def publish_to_app_service
    Aris.publish(self)
  end

  def publish_to_jenkins_service
    JenkinsService.publish(self)
  end

  # TODO: Move in some view helper
  def view_git_clone_host
    "ssh://#{name}@#{Rails.application.config.git_ssh_public_host}:/var/apps/#{name}/code"
  end

  def public_url
  end
end
