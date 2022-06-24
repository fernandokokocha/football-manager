class DefaultKickoffEventGenerator
  def call(roster)
    KickoffEvent.new(kicker: roster.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(50))
  end
end

class ConstantKickoffEventGenerator
  def initialize(*args)
    @args = args
  end

  def call(roster)
    yards = @args.first[:yards_travelled]
    KickoffEvent.new(kicker: roster.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(yards))
  end
end
