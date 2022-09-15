class MarkerCountdown
  def initialize(first_down_yards:)
    @first_down_yards = first_down_yards
    @target = first_down_yards.from_left - 10
  end

  attr_reader :first_down_yards, :target

  def crossed?(yards)
    yards.from_left < target
  end
end
