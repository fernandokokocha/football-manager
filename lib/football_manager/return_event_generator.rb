class DefaultReturnEventGenerator
  def call
    ReturnEvent.new(yards_returned: Yards.new(30))
  end
end

class ConstantReturnEventGenerator
  def initialize(*args)
    @args = args
  end

  def call
    yards = @args.first[:yards_returned]
    ReturnEvent.new(yards_returned: Yards.new(yards))
  end
end

class RandomReturnEventGenerator
  def call
    first = 30
    last = 50
    yards = rand(first..last)
    ReturnEvent.new(yards_returned: YardsFromRange.new(yards, first, last))
  end
end
