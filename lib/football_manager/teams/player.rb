class Player
  def initialize(position:, name:)
    @position = position
    @name = name
    @skills = Skills.new
  end

  attr_reader :position, :name, :skills

  def ==(o)
    self.class == o.class &&
      self.position == o.position &&
      self.name == o.name &&
      self.skills == o.skills
  end
end
