class DefaultReturnEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReturnEvent.new(returner: roster_defence.returner, yards_returned: Yards.new(30))
  end
end

class ConstantReturnEventGenerator
  def initialize(yards_returned:)
    @yards_returned = yards_returned
  end

  attr_reader :yards_returned

  def call(roster_offence, roster_defence, current_yards)
    ReturnEvent.new(returner: roster_defence.returner, yards_returned: Yards.new(yards_returned))
  end
end

class RandomReturnEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    first = 30
    last = 50
    yards = rand(first..last)
    ReturnEvent.new(returner: roster_defence.returner, yards_returned: YardsFromRange.new(first, last, yards))
  end
end

class ScoringReturnEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReturnEvent.new(returner: roster_defence.returner, yards_returned: Yards.new(current_yards))
  end
end
