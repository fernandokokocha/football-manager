class RunPhase < BasePhase
  def initialize(runner:, yards_diff:, next_phase:, time_in_seconds:)
    @runner = runner
    super(yards_diff: yards_diff, next_phase: next_phase, time_in_seconds: time_in_seconds)
  end

  attr_reader :runner

  def who_has_ball
    runner
  end

  def ==(o)
    self.class == o.class &&
      self.runner == o.runner &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase &&
      self.time_in_seconds == o.time_in_seconds
  end
end
