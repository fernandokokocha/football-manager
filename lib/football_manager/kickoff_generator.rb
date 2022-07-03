class KickoffGenerator
  def generate(roster_1, roster_2, event_generators)
    starting_yards_num = Rules::KICKOFF_YARDS
    current_yards = starting_yards_num
    phases = [
      event_generators.kickoff.call(roster_1, roster_2, current_yards),
      event_generators.reception.call(roster_1, roster_2, current_yards),
    ]

    current_yards += phases[0].yards_travelled.number
    phases << event_generators.return.call(roster_1, roster_2, current_yards)

    current_yards -= phases[2].yards_returned.number

    ending_generator = current_yards == 0 ? :touchdown : :tackle

    ending_phase = event_generators.send(ending_generator).call(roster_1, roster_2, current_yards)
    phases << ending_phase

    ending_yards_num = current_yards

    KickoffAction.new(kicking_team: roster_1.team,
                      starting_yards: YardsInPitch.new(from_left: starting_yards_num),
                      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                      phases: phases)
  end
end
