class DebugReceptionPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Reception"
  end

  def extra_fields(phase)
    [
      "Player=#{phase.player.name};",
    ]
  end
end
