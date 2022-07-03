class DefaultKickoffEventGenerator
  def call(roster_offence, roster_defence, current_yards)
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_diff: Yards.new(50), next_event: :reception)
  end
end

class ConstantKickoffEventGenerator
  def initialize(yards_travelled:)
    @yards_travelled = yards_travelled
  end

  attr_reader :yards_travelled

  def call(roster_offence, roster_defence, current_yards)
    KickoffEvent.new(kicker: roster_offence.kicker, yards_from: Yards.new(Rules::KICKOFF_YARDS), yards_diff: Yards.new(yards_travelled), next_event: :reception)
  end
end
