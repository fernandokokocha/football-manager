class PhaseGenerators
  def initialize(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffPhaseGenerator.new)
    @reception = generators.fetch(:reception, DefaultReceptionPhaseGenerator.new)
    @return = generators.fetch(:return, DefaultReturnPhaseGenerator.new)
    @touchdown = generators.fetch(:touchdown, DefaultTouchdownPhaseGenerator.new)
    @tackle = generators.fetch(:tackle, DefaultTacklePhaseGenerator.new)
  end

  attr_reader :kickoff, :reception, :return, :touchdown, :tackle
end
