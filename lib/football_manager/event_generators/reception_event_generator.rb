class DefaultReceptionPhaseGenerator
  def call(roster_offence, roster_defence, current_yards)
    ReceptionPhase.new(player: roster_defence.returner, yards_diff: Yards.new(0), next_phase: :return)
  end
end
