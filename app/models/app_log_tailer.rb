class AppLogTailer
  def self.fetch(app)
    log_path = Rails.root.join("log/#{Rails.env}.log")
    File.exists?(log_path) or return ''
    size = File.size(log_path)
    size_to_fetch = [size, 1000].min
    offset = [size-size_to_fetch, size_to_fetch].max
    IO.binread(log_path, size_to_fetch, offset)
  end
end
