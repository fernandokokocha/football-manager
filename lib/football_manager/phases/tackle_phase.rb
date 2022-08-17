class TacklePhase < BasePhase
  def initialize(yards_diff:, next_phase:, time_in_seconds:)
    super(yards_diff: yards_diff, next_phase: next_phase, time_in_seconds: time_in_seconds)
  end

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase &&
      self.time_in_seconds == o.time_in_seconds
  end
end
