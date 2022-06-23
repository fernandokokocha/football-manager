class Generator
  def generate(team_1, team_2, return_event_generator = DefaultReturnEventGenerator.new)
    KickoffAction.new([
      KickoffEvent.new(yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
      ReceptionEvent.new,
      return_event_generator.call,
      TackleEvent.new,
    ])
  end
end
