class DebugReturnPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Return"
  end

  def extra_fields(phase)
    [
      "Returner=#{phase.returner.name};",
    ]
  end
end
