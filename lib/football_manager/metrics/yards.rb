class Yards
  def initialize(number)
    @number = number
  end

  attr_reader :number

  def crop_to_pitch(starting_yards)
    potential = starting_yards.from_left + number
    potential = 100 if (potential > 100)
    potential = 0 if (potential < 0)

    @number = potential - starting_yards.from_left
  end

  def ==(o)
    self.class == o.class && self.number == o.number
  end
end

class YardsFromRange
  def initialize(first, last, number = -1)
    @first, @last, @number = first, last, number
  end

  attr_reader :number, :first, :last

  def crop_to_pitch(starting_yards)
    potential = starting_yards.from_left + number
    potential = 100 if (potential > 100)
    potential = 0 if (potential < 0)

    @number = potential
  end

  def ==(o)
    self.class == o.class && self.first == o.first && self.last == o.last
  end
end
