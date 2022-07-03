class EventGenerators
  def initialize(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffEventGenerator.new)
    @return = generators.fetch(:return, DefaultReturnEventGenerator.new)
  end

  attr_reader :kickoff, :return
end
