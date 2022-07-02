class YardsInPitch
  def initialize(from_left:)
    @from_left = from_left
  end

  attr_reader :from_left

  def ==(o)
    self.class == o.class && self.from_left == o.from_left
  end
end
