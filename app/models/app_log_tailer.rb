class AppLogTailer
  def self.fetch(app)
    path = log_path(app)
    File.exists?(path) or return "Log file not found: #{log_path}"
    size = File.size(path)
    size_to_fetch = [size, 200000].min
    offset = [size-size_to_fetch, size_to_fetch].max
    IO.binread(path, size_to_fetch, offset)
  end

  # TODO: uargs
  def self.log_path(app)
    "/var/apps/#{app.name}/logs/rails.log"
  end
end
