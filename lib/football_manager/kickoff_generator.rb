class KickoffGenerator
  def generate(roster_1, roster_2, event_generators)
    starting_yards_num = Rules::KICKOFF_YARDS
    phases = [
      event_generators.kickoff.call(roster_1, roster_2),
      ReceptionEvent.new(player: roster_2.returner),
    ]

    current_yards = starting_yards_num + phases[0].yards_travelled.number
    phases << event_generators.return.call(roster_1, roster_2, current_yards)

    ending_yards_num = starting_yards_num + phases[0].yards_travelled.number - phases[2].yards_returned.number

    ending_phase = ending_yards_num == 0 ? TouchdownEvent.new(player: phases[2].returner) : TackleEvent.new
    phases << ending_phase

    KickoffAction.new(kicking_team: roster_1.team,
                      starting_yards: YardsInPitch.new(from_left: starting_yards_num),
                      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                      phases: phases)
  end
end
