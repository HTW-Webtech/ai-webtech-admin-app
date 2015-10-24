require 'pathname'

class AppLogTailer
  def initialize(app)
    @app = app
  end

  def log_base_path
    Pathname.new("/var/apps/#{app.name}/logs")
  end
end

class AppLogTailer::Index < AppLogTailer
  def log_files
    Dir["#{log_base_path}/*.log"].map { |path| File.basename(path) }
  end
end

class AppLogTailer::Show
  attr_reader :app, :log_file_name

  def initialize(app, log_file_name)
    @app = app
    @log_file_name = log_file_name
    valid? or raise StandardError, "Invalid log_file: #{log_file_name}"
  end

  def valid?
    index = AppLogTailer::Index.new
    index.log_files.include? log_file_name
  end

  def log_file_path
    log_base_path + log_file_name
  end

  def log_file_size
    @log_file_size ||= File.size(log_file_path)
  end

  def max_bytes_to_fetch
    [log_file_size, 200000].min
  end

  def offset_bytes
    return 0 unless log_file_size > max_bytes_to_fetch
    [log_file_size-max_bytes_to_fetch, max_bytes_to_fetch].max
  end

  def fetch
    File.exists?(log_file_path) or return "Log file not found: #{log_file_path}"
    result = "Fetching: #{log_file_path}, Size: #{max_bytes_to_fetch}, Offset: #{offset_bytes}\n\n"
    result += IO.binread(log_file_path, max_bytes_to_fetch, offset_bytes)
    result
  end
end
