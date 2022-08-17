class TouchdownPhase < BasePhase
  def initialize(player:, yards_diff:, next_phase:, time_in_seconds:)
    @player = player
    super(yards_diff: yards_diff, next_phase: next_phase, time_in_seconds: time_in_seconds)
  end

  attr_reader :player

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase &&
      self.time_in_seconds == o.time_in_seconds
  end

  def touchdown?
    true
  end
end
