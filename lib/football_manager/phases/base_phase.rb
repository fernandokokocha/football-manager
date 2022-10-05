class BasePhase
  def initialize(yards_diff:, next_phase:, time_in_seconds:)
    @yards_diff = yards_diff
    @next_phase = next_phase
    @time_in_seconds = time_in_seconds
  end

  attr_reader :yards_diff, :next_phase, :time_in_seconds
  attr_writer :next_phase

  def touchdown?
    false
  end

  def kickoff?
    false
  end

  def type
    self.class.to_s.delete_suffix("Phase")
  end

  def debug
    puts "#{self.class.name} yards_diff=#{yards_diff.number} next_phase=#{next_phase} time_in_seconds=#{time_in_seconds}"
  end
end
