require 'file/tail'
require 'securerandom'

class App < ActiveRecord::Base
  belongs_to :user

  attr_accessor :env_vars_view

  before_save :transform_env_vars_view
  after_save :publish_to_aris

  after_initialize do
    if self.new_record?
      self.name        = AppName.generate_unique
      self.email       = user.email
      self.ssh_key     = user.ssh_key
      self.pg_database = self.name
      self.pg_login    = self.name
      self.pg_passwd   = SecureRandom.uuid
    end
  end

  def is_active?
    true
  end

  def fetch_logs
    lines = []
    @logs ||= File::Tail::Logfile.tail(rails_log_path, backward: 500) do |line|
      lines << line
    end
    lines.join
  end

  private

  def rails_log_path
    # FIXME: Better access via Rails.logger somehow
    Rails.root.join("log/#{Rails.env}.log")
  end

  def publish_to_aris
    Aris.update_app(self)
  end

  def transform_env_vars_view
    self.env_vars = AppEnvVars.encode(self.env_vars_view)
  end
end
