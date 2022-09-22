class DefaultTacklePhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0)
  end
end
