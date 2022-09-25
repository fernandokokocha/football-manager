class DebugSnapPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Snap"
  end

  def extra_fields(phase)
    [
      "Snaper=#{phase.snaper.name};",
    ]
  end
end
