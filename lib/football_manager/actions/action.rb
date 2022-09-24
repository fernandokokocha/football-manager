class Action
  def initialize(starting_team:, starting_yards:, ending_yards:, phases:)
    @starting_team = starting_team
    @starting_yards = starting_yards
    @ending_yards = ending_yards
    @phases = phases
  end

  attr_reader :starting_team, :starting_yards, :ending_yards, :phases

  def ==(o)
    self.class == o.class &&
      self.starting_team == o.starting_team &&
      self.starting_yards == o.starting_yards &&
      self.ending_yards == o.ending_yards &&
      self.phases == o.phases
  end

  def kickoff?
    phases.first.kickoff?
  end

  def action?
    not kickoff?
  end

  def ends_with_touchdown?
    phases.last.touchdown?
  end

  def time_in_seconds
    phases.map(&:time_in_seconds).inject(0, &:+)
  end

  def ends_with_touchdown_of?(roster)
    ends_with_touchdown? && roster.includes?(phases.last.player)
  end

  def ends_with_tackle_while_possesion_of?(roster)
    (not ends_with_touchdown?) && roster.includes?(phases[-2].who_has_ball)
  end

  def debug
    puts "Team id: #{starting_team.object_id}, starting yards: #{starting_yards.from_left}, ending yards: #{ending_yards.from_left}"
  end
end
