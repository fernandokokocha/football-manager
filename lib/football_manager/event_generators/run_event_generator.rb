class DefaultRunPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    RunPhase.new(runner: roster_offence.qb, yards_diff: Yards.new(20), next_phase: :tackle)
  end
end
