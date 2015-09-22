class Aris
  def self.publish(app)
    bookkeeper.add(app.name, app_opts(app))
  end

  # TODO: Make pg_passwd => pg_password
  def self.app_opts(app)
    opts = {}
    opts[:name]     = app.name
    opts[:email]    = app.email
    opts[:ssh_key]  = app.ssh_key
    opts[:env_vars] = app.env_vars
    opts[:env_vars] = opts[:env_vars].merge(
      pg_host: app.pg_host,
      pg_database: app.pg_database,
      pg_login: app.pg_login,
      pg_password: app.pg_passwd,
    )
    opts
  end

  def self.bookkeeper
    # TODO: Config for bookkeeper?
    @bookkeeper ||= ArisControl::Bookkeeper.new
  end
end
