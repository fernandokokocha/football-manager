class YardsInPitch
  def initialize(from_left: nil, from_right: nil)
    @from_left = from_left ? from_left : 100 - from_right
    @from_right = from_right ? from_right : 100 - from_left
  end

  def self.from_first_down_plus(yards)
    self.new(from_left: yards.from_left + 10)
  end

  def self.from_first_down_minus(yards)
    self.new(from_left: yards.from_left - 10)
  end

  attr_reader :from_left, :from_right

  def crossed_minus?(yards)
    yards.from_left < self.from_left
  end

  def crossed_plus?(yards)
    yards.from_left > self.from_left
  end

  def add_diff(yards)
    num = self.from_left + yards.number
    num = 100 if (num > 100)
    num = 0 if (num < 0)

    YardsInPitch.new(from_left: num)
  end

  def ==(o)
    self.class == o.class &&
    self.from_left == o.from_left
    self.from_right == o.from_right
  end
end
