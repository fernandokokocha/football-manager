class KickoffGenerator
  def initialize(time_in_seconds: nil)
    @time_in_seconds = time_in_seconds
  end

  attr_reader :time_in_seconds

  def generate(roster_1, roster_2, event_generators)
    starting_yards_num = Rules::KICKOFF_YARDS

    current_yards = starting_yards_num
    next_phase = :kickoff

    phases = []
    while (next_phase != nil)
      phases << event_generators.send(next_phase).call(roster_1, roster_2, current_yards)
      current_yards += phases.last.yards_diff.number
      next_phase = phases.last.next_phase
    end

    ending_yards_num = current_yards

    Action.new(starting_team: roster_1.team,
                      starting_yards: YardsInPitch.new(from_left: starting_yards_num),
                      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                      phases: phases,
                      time_in_seconds: @time_in_seconds || 30)
  end
end
