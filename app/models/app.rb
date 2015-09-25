require 'securerandom'

class App < ActiveRecord::Base
  belongs_to :user

  serialize :env_vars, JSON

  after_save :publish_to_aris

  after_initialize do
    if self.new_record?
      self.name        ||= AppName.generate_unique
      self.email       ||= user.email   if user
      self.ssh_key     ||= user.ssh_key if user
      self.pg_database ||= self.name
      self.pg_login    ||= self.name
      self.pg_passwd   ||= SecureRandom.uuid
      self.env_vars    ||= { 'FOO' => 'BAR' }
    end
  end

  def is_active?
    true
  end

  def fetch_logs
    @logs ||= AppLogTailer.fetch(self)
  end

  def publish_to_aris
    Aris.publish(self)
  end

  # TODO: Move in some view helper
  def view_git_clone_host
    "ssh://#{name}@#{Rails.application.config.git_ssh_public_host}:/var/apps/#{name}/code"
  end
end
