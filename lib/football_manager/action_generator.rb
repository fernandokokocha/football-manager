class ActionGenerator
  def initialize(time_in_seconds: nil)
    @time_in_seconds = time_in_seconds
  end

  attr_reader :time_in_seconds

  def generate(offence_roster, defence_roster, starting_yards, next_phase, event_generators)
    current_yards = starting_yards.from_left

    phases = []
    while (next_phase != nil)
      phases << event_generators.send(next_phase).call(offence_roster, defence_roster, current_yards)
      current_yards += phases.last.yards_diff.number
      next_phase = phases.last.next_phase
    end

    ending_yards_num = current_yards

    Action.new(
      starting_team: offence_roster.team,
      starting_yards: starting_yards,
      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
      phases: phases,
      time_in_seconds: time_in_seconds || 30,
    )
  end
end
