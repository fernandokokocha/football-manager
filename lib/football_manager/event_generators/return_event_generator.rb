class DefaultReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReturnPhase.new(returner: roster_defence.returner, yards_diff: Yards.new(-30), next_event: :tackle)
  end
end

class ConstantReturnPhaseGenerator
  def initialize(yards_returned:)
    @yards_returned = yards_returned
  end

  attr_reader :yards_returned

  def call(roster_offence, roster_defence, current_yards)
    ReturnPhase.new(returner: roster_defence.returner, yards_diff: Yards.new(-yards_returned), next_event: :tackle)
  end
end

class RandomReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    first = -50
    last = -30
    yards = rand(first..last)
    ReturnPhase.new(returner: roster_defence.returner, yards_diff: YardsFromRange.new(first, last, yards), next_event: :tackle)
  end
end

class ScoringReturnPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReturnPhase.new(returner: roster_defence.returner, yards_diff: Yards.new(-current_yards), next_event: :touchdown)
  end
end
