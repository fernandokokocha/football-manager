class KickoffEvent
  def initialize(*args)
    @args = args
  end

  attr_reader :args

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end

class ReceptionEvent
  def initialize(*args)
    @args = args
  end

  attr_reader :args

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end

class ReturnEvent
  def initialize(*args)
    @args = args
  end

  attr_reader :args

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end

class TackleEvent
  def initialize(*args)
    @args = args
  end

  attr_reader :args

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end
