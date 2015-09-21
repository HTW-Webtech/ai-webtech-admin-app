class AppName
  # TODO: Create more of those :)
  PREFIX = %w(cherry alluring meaty swift woopy sharp speedy wonky)
  NAMES = %w(blossom hound boar archid baham furud stewie brian)

  def self.generate_unique
    "#{App.count+1}-#{pick_prefix}-#{pick_name}"
  end

  private
    def self.pick_prefix
      PREFIX[rand(Range.new(0, PREFIX.count-1))]
    end

    def self.pick_name
      NAMES[rand(Range.new(0, NAMES.count-1))]
    end
end
