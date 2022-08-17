class RunPhase < BasePhase
  def initialize(runner:, yards_diff:, next_phase:)
    @runner = runner
    super(yards_diff: yards_diff, next_phase: next_phase)
  end

  attr_reader :runner

  def ==(o)
    self.class == o.class &&
      self.runner == o.runner &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase
  end
end
