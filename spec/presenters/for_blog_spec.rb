RSpec.describe DebugMatchPresenter do
  let(:presenter) { DebugMatchPresenter.new }

  describe "with default match with one action" do
    xit "generates text description" do
      @team_1 = Team.new
      @kicker_1 = Player.new(position: "K", name: "Kamil Jedynka")
      @returner_1 = Player.new(position: "KR", name: "Roman Jedynak")
      @qb_1 = Player.new(position: "QB", name: "Qba Adin")
      @center_1 = Player.new(position: "C", name: "Cezary Jedyński")
      @roster_1 = Roster.new(team: @team_1, kicker: @kicker_1, qb: @qb_1, center: @center_1, returner: @returner_1)

      @team_2 = Team.new
      @kicker_2 = Player.new(position: "K", name: "Krzysztof Dwójski")
      @returner_2 = Player.new(position: "KR", name: "Robert Dwa")
      @qb_2 = Player.new(position: "QB", name: "Quentin Podwójny")
      @center_2 = Player.new(position: "C", name: "Czarek Dos")
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

      @phase_generators = PhaseGenerators.new({
        run: RandomRunPhaseGenerator.new(-1, 30),
      })
      @action_generator = ActionGenerator.new(@phase_generators)

      @match_generator = MatchGenerator.new(
        action_generator: @action_generator,
        home_roster: @roster_1,
        away_roster: @roster_2,
      )
      @match_generator.generate_whole

      puts presenter.present(@match_generator.match)
    end
  end
end
