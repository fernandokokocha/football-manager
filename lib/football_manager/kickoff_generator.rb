class KickoffGenerator
  def generate(roster_1, roster_2, event_generators)
    KickoffAction.new(offence_team: roster_1.team, phases: [
                        event_generators.kickoff.call(roster_1, roster_2),
                        ReceptionEvent.new,
                        event_generators.return.call(roster_1, roster_2),
                        TackleEvent.new,
                      ])
  end
end
