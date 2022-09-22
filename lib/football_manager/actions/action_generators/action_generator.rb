class ActionGenerator
  def initialize(phase_generators)
    @phase_generators = phase_generators
  end

  attr_reader :phase_generators

  def generate(offence_roster, defence_roster, starting_yards, next_phase)
    current_yards = starting_yards.from_left

    phases = []

    progress = ProgressCountup.new

    while (next_phase != nil)
      phase = phase_generators.send(next_phase).call(offence_roster, defence_roster, current_yards, progress)
      phases << phase

      if (turnover?(phase))
        progress = progress.flip
      end

      current_yards += phases.last.yards_diff.number
      next_phase = phases.last.next_phase
    end

    ending_yards_num = current_yards

    Action.new(
      starting_team: offence_roster.team,
      starting_yards: starting_yards,
      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
      phases: phases,
    )
  end

  def turnover?(phase)
    [:return].include?(phase.next_phase)
  end
end
