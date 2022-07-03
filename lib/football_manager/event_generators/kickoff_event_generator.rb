class DefaultKickoffEventGenerator
  def call(roster_offence, roster_defence)
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(50))
  end
end

class ConstantKickoffEventGenerator
  def initialize(yards_travelled:)
    @yards_travelled = yards_travelled
  end

  attr_reader :yards_travelled

  def call(roster_offence, roster_defence)
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_travelled: Yards.new(yards_travelled))
  end
end
