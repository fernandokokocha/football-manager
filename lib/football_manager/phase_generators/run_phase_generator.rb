class DefaultRunPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    RunPhase.new(runner: roster_offence.qb, yards_diff: Yards.new(20), next_phase: :tackle, time_in_seconds: 30)
  end
end
