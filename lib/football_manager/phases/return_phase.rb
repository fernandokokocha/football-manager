class ReturnPhase < BasePhase
  def initialize(returner:, yards_diff:, next_event:)
    @returner = returner
    super(yards_diff: yards_diff, next_event: next_event)
  end

  attr_reader :returner

  def ==(o)
    self.class == o.class &&
      self.returner == o.returner &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end
