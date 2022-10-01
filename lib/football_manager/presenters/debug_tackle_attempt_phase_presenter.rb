class DebugTackleAttemptPhasePresenter < BaseDebugPhasePresenter
  def phase_name
    "Tackle"
  end

  def extra_fields(phase)
    [
      "BallHolder=#{phase.ball_holder.name};",
      "Tackle=#{phase.tackle.name};",
    ]
  end
end
