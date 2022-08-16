require "football_manager"

RSpec.describe Match do
  let(:team_1) { Team.new }
  let(:returner) { Player.new(position: "KR", name: "Bartek") }

  let(:match) { Match.new }

  describe "#next_action" do
    subject(:next_action) { match.next_action }

    it "starts with home team kickoff" do
      expect(match.next_action).to eq(:home_kickoff)
    end

    describe "after non scoring kickoff" do
      let(:kickoff) {
        KickoffAction.new(kicking_team: team_1,
                          starting_yards: YardsInPitch.new(from_left: 35),
                          ending_yards: YardsInPitch.new(from_left: 20),
                          phases: [
                            TacklePhase.new(yards_diff: Yards.new(0), next_event: nil),
                          ],
                          time_in_seconds: 30)
      }

      it "its away team attepmt" do
        match.add_action(kickoff)
        expect(match.next_action).to eq(:away_attempt)
      end
    end

    describe "after kickoff with scoring return" do
      let(:kickoff) {
        KickoffAction.new(kicking_team: team_1,
                          starting_yards: YardsInPitch.new(from_left: 35),
                          ending_yards: YardsInPitch.new(from_left: 0),
                          phases: [
                            TouchdownPhase.new(player: returner, yards_diff: Yards.new(0), next_event: nil),
                          ],
                          time_in_seconds: 30)
      }

      it "its home team attepmt" do
        match.add_action(kickoff)
        expect(match.next_action).to eq(:home_kickoff)
      end
    end
  end
end
