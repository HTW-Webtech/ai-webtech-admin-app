class Aris
  def self.publish(app)
    bookkeeper.add(app.name, app_opts(app))
    write_semaphore(app)
  end

  def self.write_semaphore(app)
    IO.binwrite(app.semaphore_file_path, "Time: #{Time.now.to_s}")
  end

  def self.app_opts(app)
    opts = {}
    opts[:name]     = app.name
    opts[:email]    = app.user.email
    opts[:ssh_key]  = app.ssh_key
    opts[:env_vars] = app.env_vars || {}
    opts[:env_vars] = opts[:env_vars].merge(
      pg_host: app.pg_host,
      pg_database: app.pg_database,
      pg_login: app.pg_login,
      pg_password: app.pg_passwd,
    )
    opts
  end

  def self.bookkeeper
    @bookkeeper = ArisControl::Bookkeeper.new
  end
end
