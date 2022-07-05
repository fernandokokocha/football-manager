class TacklePhase < BasePhase
  def initialize(yards_diff:, next_event:)
    super(yards_diff: yards_diff, next_event: next_event)
  end

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end
