class KickoffAction
  def initialize(kicking_team:, starting_yards:, ending_yards:, phases:, time_in_seconds:)
    @kicking_team = kicking_team
    @starting_yards = starting_yards
    @ending_yards = ending_yards
    @phases = phases
    @time_in_seconds = time_in_seconds
  end

  attr_reader :kicking_team, :starting_yards, :ending_yards, :phases, :time_in_seconds

  def ==(o)
    self.class == o.class &&
      self.kicking_team == o.kicking_team &&
      self.starting_yards == o.starting_yards &&
      self.ending_yards == o.ending_yards &&
      self.phases == o.phases &&
      self.time_in_seconds == o.time_in_seconds
  end

  def kickoff?
    true
  end

  def ends_with_touchdown?
    phases.last.touchdown?
  end
end
