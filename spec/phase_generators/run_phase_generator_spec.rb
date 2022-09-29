RSpec.describe RandomRunPhaseGenerator do
  describe "#call" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:runner) { Player.new(position: "QB", name: "Qba") }
    let(:roster_1) { Roster.new(team: team_1, qb: runner) }
    let(:roster_2) { Roster.new(team: team_2) }
    let(:current_yards) { 35 }
    let(:progress) { ProgressCountup.new }
    let(:run_phase_generator) { RandomRunPhaseGenerator.new(10, 20) }

    subject(:run_phase) { run_phase_generator.call(roster_1, roster_2, current_yards, progress) }

    describe "with random data" do
      it "generates run ending with tackle" do
        expect(run_phase).to eq(RunPhase.new(
          runner: runner,
          yards_diff: YardsFromRange.new(10, 20),
          next_phase: :tackle,
          time_in_seconds: 30,
        ))
      end
    end

    describe "with random data always leading to touchdown" do
      let(:run_phase_generator) { RandomRunPhaseGenerator.new(100, 200) }

      it "generates run ending with touchdown" do
        expect(run_phase).to eq(RunPhase.new(
          runner: runner,
          yards_diff: YardsFromRange.new(100, 200),
          next_phase: :touchdown,
          time_in_seconds: 30,
        ))
      end
    end
  end
end
