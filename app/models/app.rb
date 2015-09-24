require 'securerandom'

class App < ActiveRecord::Base
  belongs_to :user

  attr_accessor :env_vars_view
  serialize :env_vars, JSON

  before_save :transform_env_vars_view
  after_save :publish_to_aris

  after_initialize do
    if self.new_record?
      self.name        = AppName.generate_unique
      self.email       = user.email   if user
      self.ssh_key     = user.ssh_key if user
      self.pg_database = self.name
      self.pg_login    = self.name
      self.pg_passwd   = SecureRandom.uuid
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

  # TODO: Move somewhere else
  # def pg_env_vars_view
  #   <<-ENV_VAR.strip_heredoc
  #     PG_HOST: #{pg_host}
  #     PG_DATABASE: #{pg_database}
  #     PG_LOGIN: #{pg_login}
  #     PG_PASSWD: #{self.pg_passwd}
  #   ENV_VAR
  # end

  # TODO: Move in some view helper
  def view_git_clone_host
    "ssh://#{name}@#{Rails.application.secrets.git_ssh_host}:/var/apps/#{name}/code"
  end

  private

  def transform_env_vars_view
    self.env_vars = AppEnvVars.encode(self.env_vars_view)
  end
end
