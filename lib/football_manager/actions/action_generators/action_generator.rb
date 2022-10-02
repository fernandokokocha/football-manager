class ActionGenerator
  def initialize(phase_generators)
    @phase_generators = phase_generators
  end

  attr_reader :phase_generators

  def generate(offence_roster, defence_roster, starting_yards, next_phase, starting_progress)
    current_yards = starting_yards.from_left
    phases = []
    progress = starting_progress

    action_state = ActionState.new(offence_roster, defence_roster, starting_yards, next_phase, starting_progress, phase_generators)

    while (action_state.continue?)
      phases << action_state.generate_next_phase
    end

    ending_yards_num = action_state.yards

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
