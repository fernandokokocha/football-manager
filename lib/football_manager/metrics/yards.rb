class Yards
  def initialize(number)
    @number = number
  end

  attr_reader :number

  def ==(o)
    self.class == o.class && self.number == o.number
  end
end

class YardsFromRange
  def initialize(first, last, number = -1)
    @first, @last, @number = first, last, number
  end

  attr_reader :number, :first, :last

  def ==(o)
    self.class == o.class && self.first == o.first && self.last == o.last
  end
end
