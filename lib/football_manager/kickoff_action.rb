class KickoffAction
  def initialize(kicking_team:, starting_yards:, ending_yards:, phases:)
    @kicking_team = kicking_team
    @starting_yards = starting_yards
    @ending_yards = ending_yards
    @phases = phases
  end

  attr_reader :kicking_team, :starting_yards, :ending_yards, :phases

  def ==(o)
    self.class == o.class &&
      self.kicking_team == o.kicking_team &&
      self.starting_yards == o.starting_yards &&
      self.ending_yards == o.ending_yards &&
      self.phases == o.phases
  end
end
