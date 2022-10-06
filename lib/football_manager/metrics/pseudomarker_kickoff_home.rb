class PseudomarkerKickoffHome
  def initialize
    @first_down_yards = nil
    @target = nil
  end

  attr_reader :first_down_yards, :target

  def crossed?(yards)
    false
  end

  def starting_progress
    ProgressCountup.new
  end

  def ==(o)
    self.class == o.class
  end
end
