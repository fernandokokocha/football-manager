class ReturnPhase < BasePhase
  def initialize(returner:, yards_diff:, next_phase:, time_in_seconds:)
    @returner = returner
    super(yards_diff: yards_diff, next_phase: next_phase, time_in_seconds: time_in_seconds)
  end

  attr_reader :returner

  def ==(o)
    self.class == o.class &&
      self.returner == o.returner &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase &&
      self.time_in_seconds == o.time_in_seconds
  end
end
