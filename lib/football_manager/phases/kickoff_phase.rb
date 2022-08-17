class KickoffPhase < BasePhase
  def initialize(kicker:, yards_from:, yards_diff:, next_phase:)
    @kicker = kicker
    @yards_from = yards_from
    super(yards_diff: yards_diff, next_phase: next_phase)
  end

  attr_reader :kicker, :yards_from

  def ==(o)
    self.class == o.class &&
      self.kicker == o.kicker &&
      self.yards_from == o.yards_from &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase
  end
end