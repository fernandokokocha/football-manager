class BasePhase
  def initialize(yards_diff:, next_phase:, time_in_seconds:)
    @yards_diff = yards_diff
    @next_phase = next_phase
    @time_in_seconds = time_in_seconds
  end

  attr_reader :yards_diff, :next_phase, :time_in_seconds

  def touchdown?
    false
  end
end
