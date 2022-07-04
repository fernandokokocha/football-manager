class Event
  def initialize(yards_diff:, next_event:)
    @yards_diff = yards_diff
    @next_event = next_event
  end

  attr_reader :yards_diff, :next_event

  def touchdown?
    false
  end
end

class KickoffEvent < Event
  def initialize(kicker:, yards_from:, yards_diff:, next_event:)
    @kicker = kicker
    @yards_from = yards_from
    super(yards_diff: yards_diff, next_event: next_event)
  end

  attr_reader :kicker, :yards_from

  def ==(o)
    self.class == o.class &&
      self.kicker == o.kicker &&
      self.yards_from == o.yards_from &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end

class ReceptionEvent < Event
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
end

class ReturnEvent < Event
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

class TackleEvent < Event
  def initialize(yards_diff:, next_event:)
    super(yards_diff: yards_diff, next_event: next_event)
  end

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff &&
      self.next_event == o.next_event
  end
end

class TouchdownEvent < Event
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
