class Factory
  def initialize
    @team_1 = Team.new
    @team_2 = Team.new
    @kicker = Player.new(position: "K", name: "Krzysiek")
    @returner = Player.new(position: "KR", name: "Robert")
    @qb = Player.new(position: "QB", name: "Qba")
    @center = Player.new(position: "C", name: "Cezary")
    @roster_1 = Roster.new(team: @team_1, kicker: @kicker, qb: @qb, center: @center)
    @roster_2 = Roster.new(team: @team_2, returner: @returner)
    @current_yards = YardsInPitch.new(from_left: 35)
    @progress = ProgressCountup.new

    @kickoff_phase_generator = DefaultKickoffPhaseGenerator.new
    @reception_phase_generator = DefaultReceptionPhaseGenerator.new
    @return_phase_generator = DefaultReturnPhaseGenerator.new
    @run_phase_generator = DefaultRunPhaseGenerator.new
    @snap_phase_generator = DefaultSnapPhaseGenerator.new
    @tackle_phase_generator = DefaultTacklePhaseGenerator.new
    @touchdown_phase_generator = DefaultTouchdownPhaseGenerator.new
  end

  def default_phase(phase_name)
    instance_variable_get("@#{phase_name}_phase_generator").call(@roster_1, @roster_2, @current_yards, @progress)
  end
end
