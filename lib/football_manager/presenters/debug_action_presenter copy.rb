class DebugActionPresenter
  def present(action)
    new_action_header = "=== NEW ACTION ==="
    start_description = "start at #{action.starting_yards.from_left} yards"
    phases_description = action.phases.map do |phase|
      presenter_class_name = "Debug#{phase.type}PhasePresenter"
      klass = Kernel.const_get(presenter_class_name)
      klass.new.present(phase)
    end
    end_description = "end of action at #{action.ending_yards.from_left} yards"

    [
      new_action_header,
      start_description,
      *phases_description,
      end_description,
    ].join("\n")
  end
end
