class YardsInPitch
  def initialize(from_left: nil, from_right: nil)
    @from_left = from_left ? from_left : 100 - from_right
    @from_right = from_right ? from_right : 100 - from_left
  end

  attr_reader :from_left, :from_right

  def ==(o)
    self.class == o.class &&
    self.from_left == o.from_left
    self.from_right == o.from_right
  end
end
