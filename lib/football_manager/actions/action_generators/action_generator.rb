class ActionGenerator
  def initialize(phase_generators)
    @phase_generators = phase_generators
  end

  attr_reader :phase_generators

  def generate(offence_roster, defence_roster, starting_yards, next_phase, starting_progress)
    current_yards = starting_yards
    phases = []
    progress = starting_progress

    action_state = ActionState.new(offence_roster, defence_roster, starting_yards, next_phase, starting_progress, phase_generators)

    while (action_state.continue?)
      phase = action_state.generate_next_phase

      phase.yards_diff.crop_to_pitch(current_yards)

      current_yards = current_yards.add_diff(phase.yards_diff)

      if (!phase.touchdown?)
        next_phase = progress.touchdown?(current_yards.from_left) ? :touchdown : phase.next_phase
        phase.next_phase = next_phase
        action_state.next_phase = next_phase
      end

      phases << phase
    end

    ending_yards_num = current_yards

    Action.new(
      starting_team: offence_roster.team,
      starting_yards: starting_yards,
      ending_yards: ending_yards_num,
      phases: phases,
    )
  end
end
