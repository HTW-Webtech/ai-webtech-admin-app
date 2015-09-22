class AppEnvVars
  def self.encode(env_vars_from_view)
    env_vars_from_view.lines.each_with_object({}) do |line, hash|
      captures = line.strip.match(/^(\w+):\s*([\w-]+)$/i)
      hash[captures[1].upcase] = captures[2]
    end
  end
end
