RSpec.describe ActionGenerator do
  describe "#generate" do
    describe "with default setup" do
      let(:team_1) { Team.new }
      let(:team_2) { Team.new }
      let(:center) { Player.new(position: "C", name: "Cezary") }
      let(:qb) { Player.new(position: "QB", name: "Qba") }
      let(:roster_1) { Roster.new(team: team_1, center: center, qb: qb) }
      let(:roster_2) { Roster.new(team: team_2) }
      let(:starting_yards) { YardsInPitch.new(from_left: 50) }
      let(:action_generator) { Factory.new.default_action_generator }
      let(:progress) { ProgressCountup.new }

      subject(:action) { action_generator.generate(roster_1, roster_2, starting_yards, :snap, progress) }

      it "generates action with default data" do
        expect(action).to eq(Action.new(starting_team: team_1,
                                        starting_yards: YardsInPitch.new(from_left: 50),
                                        ending_yards: YardsInPitch.new(from_left: 51),
                                        phases: [
                                          SnapPhase.new(snaper: center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
                                          RunPhase.new(runner: qb, yards_diff: Yards.new(11), next_phase: :tackle, time_in_seconds: 30),
                                          TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                                        ]))
      end
    end

    describe "when about to sccore TD" do
      let(:team_1) { Team.new }
      let(:team_2) { Team.new }
      let(:center) { Player.new(position: "C", name: "Cezary") }
      let(:qb) { Player.new(position: "QB", name: "Qba") }
      let(:qb2) { Player.new(position: "QB", name: "Qba 2") }
      let(:roster_1) { Roster.new(team: team_1, center: center, qb: qb) }
      let(:roster_2) { Roster.new(team: team_2, returner: qb2) }
      let(:starting_yards) { YardsInPitch.new(from_left: 99) }
      let(:run_generator) { ConstantRunPhaseGenerator.new(50) }
      let(:generators_params) {
        {
          run: run_generator,
        }
      }
      let(:phase_generators) { PhaseGenerators.new(generators_params) }
      let(:action_generator) { ActionGenerator.new(phase_generators) }
      let(:progress) { ProgressCountup.new }

      subject(:action) { action_generator.generate(roster_1, roster_2, starting_yards, :snap, progress) }

      it "crops progress to 100 yard line and recignizes touchdown" do
        expect(action).to eq(Action.new(starting_team: team_1,
                                        starting_yards: YardsInPitch.new(from_left: 99),
                                        ending_yards: YardsInPitch.new(from_left: 100),
                                        phases: [
                                          SnapPhase.new(snaper: center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
                                          RunPhase.new(runner: qb, yards_diff: Yards.new(11), next_phase: :touchdown, time_in_seconds: 30),
                                          TouchdownPhase.new(player: qb2, yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                                        ]))
      end
    end
  end
end
