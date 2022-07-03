class Event
  def initialize(yards_diff:)
    @yards_diff = yards_diff
  end

  attr_reader :yards_diff
end

class KickoffEvent < Event
  def initialize(kicker:, yards_from:, yards_diff:)
    @kicker = kicker
    @yards_from = yards_from
    super(yards_diff: yards_diff)
  end

  attr_reader :kicker, :yards_from

  def ==(o)
    self.class == o.class &&
      self.kicker == o.kicker &&
      self.yards_from == o.yards_from &&
      self.yards_diff == o.yards_diff
  end
end

class ReceptionEvent < Event
  def initialize(player:, yards_diff:)
    @player = player
    super(yards_diff: yards_diff)
  end

  attr_reader :player

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff
  end
end

class ReturnEvent < Event
  def initialize(returner:, yards_diff:)
    @returner = returner
    super(yards_diff: yards_diff)
  end

  attr_reader :returner

  def ==(o)
    self.class == o.class &&
      self.returner == o.returner &&
      self.yards_diff == o.yards_diff
  end
end

class TackleEvent < Event
  def initialize(yards_diff:)
    super(yards_diff: yards_diff)
  end

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff
  end
end

class TouchdownEvent < Event
  def initialize(player:, yards_diff:)
    @player = player
    super(yards_diff: yards_diff)
  end

  attr_reader :player

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff
  end
end
