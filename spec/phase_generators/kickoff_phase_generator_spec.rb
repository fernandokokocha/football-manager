RSpec.describe DefaultKickoffPhaseGenerator do
  describe "#call" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new(position: "K", name: "Krzysiek") }
    let(:returner) { Player.new(position: "KR", name: "Robert") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker) }
    let(:roster_2) { Roster.new(team: team_2, returner: returner) }
    let(:current_yards) { YardsInPitch.new(from_left: 35) }

    let(:kickoff_phase_generator) { DefaultKickoffPhaseGenerator.new }
    subject(:kickoff_phase) { kickoff_phase_generator.call(roster_1, roster_2, current_yards, progress) }

    describe "with progress countup" do
      let(:progress) { ProgressCountup.new }

      it "generates kickoff off with yards diff progress on plus" do
        expect(kickoff_phase).to eq(KickoffPhase.new(
          kicker: kicker,
          yards_from: Yards.new(35),
          yards_diff: Yards.new(50),
          next_phase: :reception,
          time_in_seconds: 15,
        ))
      end
    end

    describe "with progress countdown" do
      let(:progress) { ProgressCountdown.new }

      it "generates kickoff off with yards diff on minus" do
        expect(kickoff_phase).to eq(KickoffPhase.new(
          kicker: kicker,
          yards_from: Yards.new(35),
          yards_diff: Yards.new(-50),
          next_phase: :reception,
          time_in_seconds: 15,
        ))
      end
    end
  end
end
