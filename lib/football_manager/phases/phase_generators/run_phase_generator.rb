class DefaultRunPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    RunPhase.new(
      runner: roster_offence.qb,
      yards_diff: progress.to_yards(11),
      next_phase: :tackle,
      time_in_seconds: 30,
    )
  end
end

class RandomRunPhaseGenerator
  def initialize(first, last)
    @first = first
    @last = last
  end

  def call(roster_offence, roster_defence, current_yards, progress)
    yards = rand(@first..@last)
    yards_diff = progress.to_range(@first, @last, yards)

    yards_achieved = current_yards + yards_diff.number
    next_phase = progress.touchdown?(yards_achieved) ? :touchdown : :tackle
    RunPhase.new(
      runner: roster_offence.qb,
      yards_diff: yards_diff,
      next_phase: ,
      time_in_seconds: 30,
    )
  end
end
