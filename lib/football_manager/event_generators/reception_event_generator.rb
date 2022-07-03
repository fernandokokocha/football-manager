class DefaultReceptionEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReceptionEvent.new(player: roster_defence.returner, yards_diff: Yards.new(0))
  end
end
