class ArisService
  def self.publish(app)
    return true if Rails.env.development?
    bookkeeper.add(app.permalink, app_opts(app))
    write_semaphore(app)
  end

  def self.write_semaphore(app)
    IO.binwrite(app.semaphore_file_path, "Time: #{Time.now.to_s}")
  end

  def self.app_opts(app)
    opts = {}
    opts[:name]     = app.permalink
    opts[:email]    = app.user.email
    opts[:ssh_key]  = app.ssh_key
    opts[:env_vars] = app.env_vars || {}
    opts
  end

  def self.bookkeeper
    @bookkeeper = ArisControl::Bookkeeper.new
  end
end
