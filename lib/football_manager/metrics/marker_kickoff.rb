class MarkerKickoff
  def crossed?(yards)
    false
  end

  def starting_progress
    ProgressCountup.new
  end
end
