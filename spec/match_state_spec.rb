require "football_manager"

RSpec.describe MatchState do
  let(:match_state) { MatchState.new }

  subject(:next_action_setup) { match_state.next_action_setup }

  it "starts with kickoff" do
    expect(next_action_setup).to eq(ActionSetup.new(
      team: :home,
      type: :kickoff,
      ball_yards: YardsInPitch.new(from_left: 35),
    ))
  end

  describe "when kickoff ends with return touchdown" do
    before(:each) do
      match_state.away_touchdown
    end

    it "is another kickoff" do
      expect(next_action_setup).to eq(ActionSetup.new(
        team: :home,
        type: :kickoff,
        ball_yards: YardsInPitch.new(from_left: 35),
      ))
    end
  end

  describe "when kickoff ends with home touchdown" do
    before(:each) do
      match_state.home_touchdown
    end

    it "is another kickoff" do
      expect(next_action_setup).to eq(ActionSetup.new(
        team: :away,
        type: :kickoff,
        ball_yards: YardsInPitch.new(from_right: 35),
      ))
    end
  end
end
