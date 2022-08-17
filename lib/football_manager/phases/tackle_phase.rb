class TacklePhase < BasePhase
  def initialize(yards_diff:, next_phase:)
    super(yards_diff: yards_diff, next_phase: next_phase)
  end

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase
  end
end
