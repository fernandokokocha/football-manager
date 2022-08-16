class PhaseGenerators
  def initialize(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffPhaseGenerator.new)
    @reception = generators.fetch(:reception, DefaultReceptionPhaseGenerator.new)
    @return = generators.fetch(:return, DefaultReturnPhaseGenerator.new)
    @touchdown = generators.fetch(:touchdown, DefaultTouchdownPhaseGenerator.new)
    @tackle = generators.fetch(:tackle, DefaultTacklePhaseGenerator.new)
    @snap = generators.fetch(:tackle, DefaultSnapPhaseGenerator.new)
    @run = generators.fetch(:tackle, DefaultRunPhaseGenerator.new)
  end

  attr_reader :kickoff, :reception, :return, :touchdown, :tackle, :snap, :run
end
