class Skills
  def initialize
    @run = 5
    @speed = 5
    @tackle = 5
  end

  attr_reader :run, :speed, :tackle

  def ==(o)
    self.class == o.class &&
      self.run == o.run &&
      self.speed == o.speed &&
      self.tackle == o.tackle
  end
end
