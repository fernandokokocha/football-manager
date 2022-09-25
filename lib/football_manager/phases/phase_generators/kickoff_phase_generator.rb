class DefaultKickoffPhaseGenerator
  def call(roster_offence, roster_defence, current_yards, progress)
    KickoffPhase.new(
      kicker: roster_offence.kicker,
      yards_from: YardsInPitch.new(from_left: Rules::KICKOFF_YARDS),
      yards_diff: progress.to_yards(20),
      next_phase: :reception,
      time_in_seconds: 15,
    )
  end
end

class ConstantKickoffPhaseGenerator
  def initialize(yards_travelled:)
    @yards_travelled = yards_travelled
  end

  attr_reader :yards_travelled

  def call(roster_offence, roster_defence, current_yards, progress)
    KickoffPhase.new(
      kicker: roster_offence.kicker,
      yards_from: YardsInPitch.new(from_left: Rules::KICKOFF_YARDS),
      yards_diff: progress.to_yards(yards_travelled),
      next_phase: :reception,
      time_in_seconds: 15,
    )
  end
end
