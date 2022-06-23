class Generator
  def generate(team_1, team_2)
    KickoffAction.new([
      KickoffEvent.new(yards_from: 35, yards_travelled: 50),
      ReceptionEvent.new,
      ReturnEvent.new(yards_returned: 30),
      TackleEvent.new,
    ])
  end
end
