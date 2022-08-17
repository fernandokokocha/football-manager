class Action
  def initialize(starting_team:, starting_yards:, ending_yards:, phases:, time_in_seconds:)
    @starting_team = starting_team
    @starting_yards = starting_yards
    @ending_yards = ending_yards
    @phases = phases
    @time_in_seconds = time_in_seconds
  end

  attr_reader :starting_team, :starting_yards, :ending_yards, :phases, :time_in_seconds

  def ==(o)
    self.class == o.class &&
      self.starting_team == o.starting_team &&
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
