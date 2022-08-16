class ActionGenerator
  def initialize(time_in_seconds: nil)
    @time_in_seconds = time_in_seconds
  end

  attr_reader :time_in_seconds

  def generate(offence_roster, defence_roster, starting_yards, event_generators)
    current_yards = starting_yards.from_left
    next_event = :snap

    phases = []
    while (next_event != nil)
      phases << event_generators.send(next_event).call(offence_roster, defence_roster, current_yards)
      current_yards += phases.last.yards_diff.number
      next_event = phases.last.next_event
    end

    ending_yards_num = current_yards

    Action.new(
      offence_team: offence_roster.team,
      starting_yards: YardsInPitch.new(from_left: 50),
      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
      phases: phases,
      time_in_seconds: 30,
    )
  end
end
