class PhaseGenerators
  def initialize(generators)
    update_generator_params(generators)
  end

  attr_accessor :kickoff, :reception, :return, :touchdown, :tackle, :tackle_attempt, :snap, :run, :sprint

  def update_generator_params(generators)
    @kickoff = generators.fetch(:kickoff, DefaultKickoffPhaseGenerator.new)
    @reception = generators.fetch(:reception, DefaultReceptionPhaseGenerator.new)
    @return = generators.fetch(:return, DefaultReturnPhaseGenerator.new)
    @touchdown = generators.fetch(:touchdown, DefaultTouchdownPhaseGenerator.new)
    @tackle = generators.fetch(:tackle, DefaultTacklePhaseGenerator.new)
    @tackle_attempt = generators.fetch(:tackle_attempt, SkillBasedTackleAttemptPhaseGenerator.new)
    @snap = generators.fetch(:snap, DefaultSnapPhaseGenerator.new)
    @run = generators.fetch(:run, DefaultRunPhaseGenerator.new)
    @sprint = generators.fetch(:sprint, SkillBasedSprintPhaseGenerator.new)
  end
end
