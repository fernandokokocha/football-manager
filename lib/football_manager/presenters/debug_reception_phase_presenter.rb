class DebugReceptionPhasePresenter
  def present(kickoff_phase)
    description = [
      "[Reception]",
      "Player=#{kickoff_phase.player.name};",
      "YardsDiff=#{kickoff_phase.yards_diff.number};",
      "NextPhase=#{kickoff_phase.next_phase};",
      "TimeInSeconds=#{kickoff_phase.time_in_seconds};",
  ].join(" ")
  end
end
