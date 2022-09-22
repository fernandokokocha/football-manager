class Player
  def initialize(position:, name:)
    @position = position
    @name = name
  end

  attr_reader :position, :name

  def ==(o)
    self.class == o.class &&
      self.position == o.position &&
      self.name == o.name
  end
end
