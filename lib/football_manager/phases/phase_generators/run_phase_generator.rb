class DefaultRunPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    RunPhase.new(
      runner: roster_offence.qb,
      yards_diff: progress.to_yards(20),
      next_phase: :tackle,
      time_in_seconds: 30,
    )
  end
end
