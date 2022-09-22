class WholeGameActionGenerator
  def initialize(phase_generators)
    @phase_generators = phase_generators
    phase_generators.return = WholeGameReturnPhaseGenerator.new
  end

  attr_reader :phase_generators

  def generate(offence_roster, defence_roster, starting_yards, next_phase)
    current_yards = starting_yards.from_left

    phases = []
    while (next_phase != nil)
      phases << phase_generators.send(next_phase).call(offence_roster, defence_roster, current_yards)
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
end
