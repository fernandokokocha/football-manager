class TouchdownPhase < BasePhase
  def initialize(player:, yards_diff:, next_event:)
    @player = player
    super(yards_diff: yards_diff, next_event: next_event)
  end

  attr_reader :player

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end

  def touchdown?
    true
  end
end
