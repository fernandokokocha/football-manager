class DefaultSnapPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    SnapPhase.new(snaper: roster_offence.center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0)
  end
end
