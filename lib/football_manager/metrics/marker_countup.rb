class MarkerCountup
  def initialize(first_down_yards:)
    @first_down_yards = first_down_yards
    @target = first_down_yards.from_left + 10
  end

  attr_reader :first_down_yards, :target

  def crossed?(yards)
    yards.from_left > target
  end

  def starting_progress
    ProgressCountup.new
  end

  def ==(o)
    self.class == o.class &&
      self.first_down_yards == o.first_down_yards
  end
end
