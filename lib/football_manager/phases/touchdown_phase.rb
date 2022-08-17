class TouchdownPhase < BasePhase
  def initialize(player:, yards_diff:, next_phase:)
    @player = player
    super(yards_diff: yards_diff, next_phase: next_phase)
  end

  attr_reader :player

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff &&
      self.next_phase == o.next_phase
  end

  def touchdown?
    true
  end
end
