class DefaultTouchdownPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    TouchdownPhase.new(player: roster_defence.returner, yards_diff: Yards.new(0), next_phase: nil)
  end
end
