class DefaultTackleEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    TackleEvent.new(yards_diff: Yards.new(0), next_event: nil)
  end
end
