class DebugKickoffPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Kickoff"
  end

  def extra_fields(phase)
    [
      "Kicker=#{phase.kicker.name};",
      "YardsFrom=#{phase.yards_from.from_left};",
    ]
  end
end
