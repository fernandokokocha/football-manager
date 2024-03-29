class DefaultSnapPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    SnapPhase.new(
      snaper: roster_offence.center,
      yards_diff: progress.to_yards(-10),
      next_phase: :run,
      time_in_seconds: 0,
    )
  end
end
