class ProgressCountdown
  def to_yards(progress_num)
    Yards.new(-progress_num)
  end

  def to_range(first, last, yards)
    YardsFromRange.new(-last, -first, -yards)
  end

  def flip
    ProgressCountup.new
  end

  def touchdown?(yards_in_pitch)
    yards_in_pitch <= 0
  end

  def counter_touchdown?(yards_in_pitch)
    yards_in_pitch >= 100
  end

  def ==(o)
    self.class == o.class
  end
end
