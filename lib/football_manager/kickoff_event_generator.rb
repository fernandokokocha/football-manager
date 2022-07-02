class DefaultKickoffEventGenerator
  def call(roster_offence, roster_defence)
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(50))
  end
end

class ConstantKickoffEventGenerator
  def initialize(*args)
    @args = args
  end

  def call(roster_offence, roster_defence)
    yards = @args.first[:yards_travelled]
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(yards))
  end
end
