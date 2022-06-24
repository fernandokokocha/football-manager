class Generator
  def generate(roster_1, roster_2, return_event_generator = DefaultReturnEventGenerator.new)
    KickoffAction.new(offence_team: roster_1.team, phases: [
                        KickoffEvent.new(kicker: roster_1.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(50)),
                        ReceptionEvent.new,
                        return_event_generator.call,
                        TackleEvent.new,
                      ])
  end
end
