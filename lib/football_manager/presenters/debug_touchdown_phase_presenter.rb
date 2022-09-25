class DebugTouchdownPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "TD"
  end

  def extra_fields(phase)
    [
      "Player=#{phase.player.name};",
    ]
  end
end
