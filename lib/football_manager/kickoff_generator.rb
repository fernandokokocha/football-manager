class KickoffGenerator
  def generate(roster_1, roster_2, event_generators)
    phases = [
      event_generators.kickoff.call(roster_1, roster_2),
      ReceptionEvent.new,
      event_generators.return.call(roster_1, roster_2),
      TackleEvent.new,
    ]

    starting_yards_num = Rules::KICKOFF_YARDS
    ending_yards_num = starting_yards_num + phases[0].args[0][:yards_travelled].number - phases[2].args[0][:yards_returned].number
    KickoffAction.new(kicking_team: roster_1.team,
                      starting_yards: YardsInPitch.new(from_left: starting_yards_num),
                      ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                      phases: phases)
  end
end
