class SnapPhase < BasePhase
  def initialize(snaper:, yards_diff:, next_event:)
    @snaper = snaper
    super(yards_diff: yards_diff, next_event: next_event)
  end

  attr_reader :snaper

  def ==(o)
    self.class == o.class &&
      self.snaper == o.snaper &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end
