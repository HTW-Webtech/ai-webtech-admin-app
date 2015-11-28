class AppName
  PREFIX = %w(
    cherry alluring swift woopy sharp speedy wonky
    rocky cleary flashy snowy sweet sour angry
    funny silent crazy happy fluffy huge tiny mad
    loopy janky wild erratic funky kinky unique
    prominent rare spiky wise odd splendid
  )

  NAMES = %w(
    blossom hound boar archid baham furud stewie
    brian richard bird elephant panda sheep tower
    castle rabbit eagle house dolphin whale tiger
    lion monkey shebang weasel wombat capybara
  )

  def self.generate_unique
    "#{pick_prefix}-#{pick_name}"
  end

  private
    def self.pick_prefix
      PREFIX[rand(Range.new(0, PREFIX.count-1))]
    end

    def self.pick_name
      NAMES[rand(Range.new(0, NAMES.count-1))]
    end
end
