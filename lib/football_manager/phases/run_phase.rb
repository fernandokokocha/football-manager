class RunPhase < BasePhase
  def initialize(runner:, yards_diff:, next_event:)
    @runner = runner
    super(yards_diff: yards_diff, next_event: next_event)
  end

  attr_reader :runner

  def ==(o)
    self.class == o.class &&
      self.runner == o.runner &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end
