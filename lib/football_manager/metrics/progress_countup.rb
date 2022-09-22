class ProgressCountup
  def to_yards(progress_num)
    Yards.new(progress_num)
  end

  def to_range(first, last, yards)
    YardsFromRange.new(first, last, yards)
  end

  def flip
    ProgressCountdown.new
  end
end
