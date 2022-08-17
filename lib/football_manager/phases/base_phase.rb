class BasePhase
  def initialize(yards_diff:, next_phase:)
    @yards_diff = yards_diff
    @next_phase = next_phase
  end

  attr_reader :yards_diff, :next_phase

  def touchdown?
    false
  end
end
