class KickoffPhasePresenter
  def present(kickoff_phase)
    description = [
      "[Kickoff]",
      "Kicker=#{kickoff_phase.kicker.name};",
      "YardsFrom=#{kickoff_phase.yards_from.from_left};",
      "YardsDiff=#{kickoff_phase.yards_diff.number};",
      "NextPhase=#{kickoff_phase.next_phase};",
      "TimeInSeconds=#{kickoff_phase.time_in_seconds};",
  ].join(" ")
  end
end
