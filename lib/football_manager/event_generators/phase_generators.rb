class PhaseGenerators
  def initialize(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffPhaseGenerator.new)
    @reception = generators.fetch(:reception, DefaultReceptionPhaseGenerator.new)
    @return = generators.fetch(:return, DefaultReturnPhaseGenerator.new)
    @touchdown = generators.fetch(:touchdown, DefaultTouchdownPhaseGenerator.new)
    @tackle = generators.fetch(:tackle, DefaultTacklePhaseGenerator.new)
    @snap = generators.fetch(:snap, DefaultSnapPhaseGenerator.new)
    @run = generators.fetch(:run, DefaultRunPhaseGenerator.new)
  end

  attr_accessor :kickoff, :reception, :return, :touchdown, :tackle, :snap, :run
end
