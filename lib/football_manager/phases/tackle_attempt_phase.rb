class TackleAttemptPhase < BasePhase
  def initialize(ball_holder:, tackle:, yards_diff:, next_phase:, time_in_seconds:)
    @ball_holder = ball_holder
    @tackle = tackle
    super(yards_diff: yards_diff, next_phase: next_phase, time_in_seconds: time_in_seconds)
  end

  attr_reader :ball_holder, :tackle

  def who_has_ball
    ball_holder
  end

  def ==(o)
    self.class == o.class &&
      self.ball_holder == o.ball_holder &&
      self.tackle == self.tackle &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase &&
      self.time_in_seconds == o.time_in_seconds
  end
end
