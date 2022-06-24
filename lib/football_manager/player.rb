class Player
  def initialize(position, name)
    @position = position
    @name = name
  end

  attr_reader :position

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end
