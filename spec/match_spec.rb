require "football_manager"

RSpec.describe Match do
  let(:team_1) { Team.new }
  let(:returner) { Player.new(position: "KR", name: "Bartek") }

  let(:match) { Match.new }

  it "starts with home team kickoff" do
    expect(match.next_action).to eq(:home_kickoff)
  end

  it "starts with 35 from left" do
    expect(match.next_yards).to eq(YardsInPitch.new(from_left: 35))
  end

  describe "after non scoring kickoff" do
    let(:kickoff) {
      Action.new(starting_team: team_1,
                        starting_yards: YardsInPitch.new(from_left: 35),
                        ending_yards: YardsInPitch.new(from_left: 20),
                        phases: [
                          TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil),
                        ],
                        time_in_seconds: 30)
    }

    before(:each) do
      match.add_action(kickoff)
    end

    it "its away team attepmt" do
      expect(match.next_action).to eq(:away_attempt)
    end

    it "starts 20 from left" do
      expect(match.next_yards).to eq(YardsInPitch.new(from_left: 20))
    end
  end

  describe "after kickoff with scoring return" do
    let(:kickoff) {
      Action.new(starting_team: team_1,
                        starting_yards: YardsInPitch.new(from_left: 35),
                        ending_yards: YardsInPitch.new(from_left: 0),
                        phases: [
                          TouchdownPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: nil),
                        ],
                        time_in_seconds: 30)
    }

    before(:each) do
      match.add_action(kickoff)
    end

    it "its home team attepmt" do
      expect(match.next_action).to eq(:home_kickoff)
    end

    it "starts 35 from left - as kickoff normally do" do
      expect(match.next_yards).to eq(YardsInPitch.new(from_left: 35))
    end
  end
end
