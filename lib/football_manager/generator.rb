class Generator
  def generate(roster_1, roster_2, event_generators)
    KickoffAction.new(offence_team: roster_1.team, phases: [
                        event_generators.kickoff.call(roster_1),
                        ReceptionEvent.new,
                        event_generators.return.call,
                        TackleEvent.new,
                      ])
  end
end
