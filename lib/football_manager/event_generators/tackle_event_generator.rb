class DefaultTacklePhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil)
  end
end
