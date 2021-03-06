class KickoffGenerator
  def initialize(time_in_seconds: nil)
    @time_in_seconds = time_in_seconds
  end

  attr_reader :time_in_seconds

  def generate(roster_1, roster_2, event_generators)
    starting_yards_num = Rules::KICKOFF_YARDS

    current_yards = starting_yards_num
    next_event = :kickoff

    phases = []
    while (next_event != nil)
      phases << event_generators.send(next_event).call(roster_1, roster_2, current_yards)
      current_yards += phases.last.yards_diff.number
      next_event = phases.last.next_event
    end

    ending_yards_num = current_yards

    next_action = phases.last.touchdown? ? :team_1_kickoff : :team_2_attempt

    KickoffAction.new(kicking_team: roster_1.team,
                      starting_yards: YardsInPitch.new(from_left: starting_yards_num),
                      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                      phases: phases,
                      time_in_seconds: @time_in_seconds || 30,
                      next_action: next_action)
  end
end
