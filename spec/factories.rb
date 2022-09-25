class Factory
  def initialize
    @team_1 = Team.new
    @team_2 = Team.new
    @kicker = Player.new(position: "K", name: "Krzysiek")
    @returner = Player.new(position: "KR", name: "Robert")
    @roster_1 = Roster.new(team: @team_1, kicker: @kicker)
    @roster_2 = Roster.new(team: @team_2, returner: @returner)
    @current_yards = YardsInPitch.new(from_left: 35)
    @progress = ProgressCountup.new

    @kickoff_phase_generator = DefaultKickoffPhaseGenerator.new
  end

  def default_kickoff_phase
    @kickoff_phase_generator.call(@roster_1, @roster_2, @current_yards, @progress)
  end
end
