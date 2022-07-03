class KickoffEvent
  def initialize(kicker:, yards_from:, yards_diff:)
    @kicker = kicker
    @yards_from = yards_from
    @yards_diff = yards_diff
  end

  attr_reader :kicker, :yards_from, :yards_diff

  def ==(o)
    self.class == o.class &&
      self.kicker == o.kicker &&
      self.yards_from == o.yards_from &&
      self.yards_diff == o.yards_diff
  end
end

class ReceptionEvent
  def initialize(player:, yards_diff:)
    @player = player
    @yards_diff = yards_diff
  end

  attr_reader :player, :yards_diff

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff
  end
end

class ReturnEvent
  def initialize(returner:, yards_diff:)
    @returner = returner
    @yards_diff = yards_diff
  end

  attr_reader :returner, :yards_diff

  def ==(o)
    self.class == o.class &&
      self.returner == o.returner &&
      self.yards_diff == o.yards_diff
  end
end

class TackleEvent
  def initialize(yards_diff:)
    @yards_diff = yards_diff
  end

  attr_reader :yards_diff

  def ==(o)
    self.class == o.class &&
      self.yards_diff == o.yards_diff
  end
end

class TouchdownEvent
  def initialize(player:, yards_diff:)
    @player = player
    @yards_diff = yards_diff
  end

  attr_reader :player, :yards_diff

  def ==(o)
    self.class == o.class &&
      self.player == o.player &&
      self.yards_diff == o.yards_diff
  end
end
