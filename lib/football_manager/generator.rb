class Generator
  def generate(roster_1, roster_2, return_event_generator = DefaultReturnEventGenerator.new, kickoff_event_generator = DefaultKickoffEventGenerator.new)
    KickoffAction.new(offence_team: roster_1.team, phases: [
                        kickoff_event_generator.call(roster_1),
                        ReceptionEvent.new,
                        return_event_generator.call,
                        TackleEvent.new,
                      ])
  end
end
