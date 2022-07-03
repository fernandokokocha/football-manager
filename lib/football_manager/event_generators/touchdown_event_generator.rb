class DefaultTouchdownEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    TouchdownEvent.new(player: roster_defence.returner, yards_diff: Yards.new(0))
  end
end
