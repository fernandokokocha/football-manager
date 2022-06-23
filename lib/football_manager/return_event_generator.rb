class DefaultReturnEventGenerator
  def call
    ReturnEvent.new(yards_returned: 30)
  end
end

class ConstantReturnEventGenerator
  def initialize(*args)
    @args = args
  end

  def call
    ReturnEvent.new(*@args)
  end
end

class RandomReturnEventGenerator
  def call
    yards = rand(30..50)
    ReturnEvent.new(yards_returned: yards)
  end
end
