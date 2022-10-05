class ActionState
  def initialize(offence_roster, defence_roster, starting_yards, next_phase, starting_progress, phase_generators)
    @offence_roster = offence_roster
    @defence_roster = defence_roster
    @yards = starting_yards.from_left
    @next_phase = next_phase
    @progress = starting_progress
    @phase_generators = phase_generators
    @phases = []
  end

  attr_reader :offence_roster, :defence_roster, :yards, :next_phase, :progress, :phase_generators, :phases
  attr_writer :next_phase

  def generate_next_phase
    phase = phase_generators.send(next_phase).call(offence_roster, defence_roster, @yards, progress)
    @phases << phase

    if (turnover?(phase))
      @progress = @progress.flip
    end

    @yards += phases.last.yards_diff.number
    @next_phase = phases.last.next_phase

    phase
  end

  def turnover?(phase)
    [:return].include?(phase.next_phase)
  end

  def continue?
    next_phase != nil
  end
end
