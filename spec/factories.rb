class Factory
  def initialize
    @team_1 = Team.new
    @kicker_1 = Player.new(position: "K", name: "Krzysiek")
    @returner_1 = Player.new(position: "KR", name: "Robert")
    @qb_1 = Player.new(position: "QB", name: "Qba")
    @center_1 = Player.new(position: "C", name: "Cezary")
    @roster_1 = Roster.new(team: @team_1, kicker: @kicker_1, qb: @qb_1, center: @center_1, returner: @returner_1)

    @team_2 = Team.new
    @kicker_2 = Player.new(position: "K", name: "Krzysiek 2")
    @returner_2 = Player.new(position: "KR", name: "Robert 2")
    @qb_2 = Player.new(position: "QB", name: "Qba 2")
    @center_2 = Player.new(position: "C", name: "Cezary 2")
    @roster_2 = Roster.new(team: @team_2, kicker: @kicker_2, qb: @qb_2, center: @center_2, returner: @returner_2)

    @current_yards = YardsInPitch.new(from_left: 35)
    @progress = ProgressCountup.new

    @kickoff_phase_generator = DefaultKickoffPhaseGenerator.new
    @reception_phase_generator = DefaultReceptionPhaseGenerator.new
    @return_phase_generator = DefaultReturnPhaseGenerator.new
    @run_phase_generator = DefaultRunPhaseGenerator.new
    @snap_phase_generator = DefaultSnapPhaseGenerator.new
    @tackle_phase_generator = DefaultTacklePhaseGenerator.new
    @touchdown_phase_generator = DefaultTouchdownPhaseGenerator.new

    @phase_generators = PhaseGenerators.new({})
    @action_generator = ActionGenerator.new(@phase_generators)
  end

  def default_action_generator
    @action_generator
  end

  def default_team_home
    @team_1
  end

  def default_team_away
    @team_2
  end

  def default_phase(phase_name)
    instance_variable_get("@#{phase_name}_phase_generator").call(@roster_1, @roster_2, @current_yards, @progress)
  end

  def default_kickoff
    @action_generator.generate(
      @roster_1,
      @roster_2,
      YardsInPitch.new(from_left: Rules::KICKOFF_YARDS),
      :kickoff,
      ProgressCountup.new
    )
  end

  def default_match
    @match_generator = MatchGenerator.new(
      action_generator: @action_generator,
      home_roster: @roster_1,
      away_roster: @roster_2,
    )
    @match_generator.generate_whole
    @match_generator.match
  end

  def default_match_actions_description
    File.read("./spec/default_match_actions_description.txt")
  end

  def default_match_one_action
    @match_generator = MatchGenerator.new(
      action_generator: @action_generator,
      home_roster: @roster_1,
      away_roster: @roster_2,
    )
    @match_generator.generate_next
    @match_generator.match
  end
end
