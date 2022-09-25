class BaseDebugPhasePresenter
  def present(phase)
    [
      "[#{phase_name}]",
      *extra_fields(phase),
      "YardsDiff=#{phase.yards_diff.number};",
      "NextPhase=#{phase.next_phase};",
      "TimeInSeconds=#{phase.time_in_seconds};",
    ].join(" ")
  end

  def phase_name
    "Phase"
  end

  def extra_fields(phase)
    []
  end
end
