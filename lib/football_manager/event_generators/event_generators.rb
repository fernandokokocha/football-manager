class EventGenerators
  def initialize(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffEventGenerator.new)
    @reception = generators.fetch(:reception, DefaultReceptionEventGenerator.new)
    @return = generators.fetch(:return, DefaultReturnEventGenerator.new)
    @touchdown = generators.fetch(:touchdown, DefaultTouchdownEventGenerator.new)
    @tackle = generators.fetch(:tackle, DefaultTackleEventGenerator.new)
  end

  attr_reader :kickoff, :reception, :return, :touchdown, :tackle
end
