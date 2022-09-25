class DebugRunPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Run"
  end

  def extra_fields(phase)
    [
      "Runner=#{phase.runner.name};",
    ]
  end
end
