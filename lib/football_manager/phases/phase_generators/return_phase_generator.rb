class DefaultReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    ReturnPhase.new(
      returner: roster_defence.returner,
      yards_diff: progress.to_yards(30),
      next_phase: :tackle,
      time_in_seconds: 15,
    )
  end
end

class ConstantReturnPhaseGenerator
  def initialize(yards_returned:)
    @yards_returned = yards_returned
  end

  attr_reader :yards_returned

  def call(roster_offence, roster_defence, current_yards, progress)
    ReturnPhase.new(
      returner: roster_defence.returner,
      yards_diff: progress.to_yards(yards_returned),
      next_phase: :tackle,
      time_in_seconds: 15,
    )
  end
end

class RandomReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    first = 30
    last = 50
    yards = rand(first..last)
    ReturnPhase.new(
      returner: roster_defence.returner,
      yards_diff: progress.to_range(first, last, yards),
      next_phase: :tackle,
      time_in_seconds: 15,
    )
  end
end

class ScoringReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    ReturnPhase.new(
      returner: roster_defence.returner,
      yards_diff: progress.to_yards(current_yards),
      next_phase: :touchdown,
      time_in_seconds: 15,
    )
  end
end

class WholeGameReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    ReturnPhase.new(
      returner: roster_defence.returner,
      yards_diff: progress.to_yards(30),
      next_phase: :touchdown,
      time_in_seconds: 15 * 60,
    )
  end
end
