class BasePhase
  def initialize(yards_diff:, next_event:)
    @yards_diff = yards_diff
    @next_event = next_event
  end

  attr_reader :yards_diff, :next_event

  def touchdown?
    false
  end
end
