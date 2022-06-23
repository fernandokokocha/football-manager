class Kickoff
  def initialize(args)
    @args = args
  end

  attr_reader :args

  def ==(o)
    self.class == o.class && self.args == o.args
  end
end
