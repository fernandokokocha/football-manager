class PseudomarkerKickoffAway
  def initialize
    @first_down_yards = nil
    @target = nil
  end

  attr_reader :first_down_yards, :target
  
  def crossed?(yards)
    false
  end

  def starting_progress
    ProgressCountdown.new
  end
end
