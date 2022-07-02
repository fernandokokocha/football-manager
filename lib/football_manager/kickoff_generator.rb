class KickoffGenerator
  def generate(roster_1, roster_2, event_generators)
    KickoffAction.new(kicking_team: roster_1.team, starting_yards: YardsInPitch.new(from_left: Rules::KICKOFF_YARDS), phases: [
                        event_generators.kickoff.call(roster_1, roster_2),
                        ReceptionEvent.new,
                        event_generators.return.call(roster_1, roster_2),
                        TackleEvent.new,
                      ])
  end
end
