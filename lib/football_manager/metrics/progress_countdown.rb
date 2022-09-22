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
end
