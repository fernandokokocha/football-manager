class KickoffEvent
  def initialize(kicker:, yards_from:, yards_travelled:)
    @kicker = kicker
    @yards_from = yards_from
    @yards_travelled = yards_travelled
  end

  attr_reader :kicker, :yards_from, :yards_travelled

  def ==(o)
    self.class == o.class &&
      self.kicker == o.kicker &&
      self.yards_from == o.yards_from &&
      self.yards_travelled == o.yards_travelled
  end
end

class ReceptionEvent
  def ==(o)
    self.class == o.class
  end
end

class ReturnEvent
  def initialize(yards_returned:)
    @yards_returned = yards_returned
  end

  attr_reader :yards_returned

  def ==(o)
    self.class == o.class &&
      self.yards_returned == o.yards_returned
  end
end

class TackleEvent
  def ==(o)
    self.class == o.class
  end
end
