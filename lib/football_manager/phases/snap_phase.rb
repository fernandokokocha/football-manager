class SnapPhase < BasePhase
  def initialize(snaper:, yards_diff:, next_phase:)
    @snaper = snaper
    super(yards_diff: yards_diff, next_phase: next_phase)
  end

  attr_reader :snaper

  def ==(o)
    self.class == o.class &&
      self.snaper == o.snaper &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase
  end
end
