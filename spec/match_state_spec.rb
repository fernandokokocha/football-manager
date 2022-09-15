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
        team: :away,
        type: :kickoff,
        ball_yards: YardsInPitch.new(from_right: 35),
      ))
    end
  end

  describe "when kickoff ends with home touchdown" do
    before(:each) do
      match_state.home_touchdown
    end

    it "is another kickoff" do
      expect(next_action_setup).to eq(ActionSetup.new(
        team: :home,
        type: :kickoff,
        ball_yards: YardsInPitch.new(from_left: 35),
      ))
    end
  end

  describe "away cases" do
    describe "when kickoff ends with return without touchdown" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
      end

      it "is is first down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 40),
        ))
      end
    end

    describe "when two tackles in a row, no first down" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
      end

      it "is is second down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 2,
          ball_yards: YardsInPitch.new(from_left: 39),
        ))
      end
    end

    describe "when three tackles in a row, no first down" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 38))
      end

      it "is is third down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 3,
          ball_yards: YardsInPitch.new(from_left: 38),
        ))
      end
    end

    describe "when four tackles in a row, no first down" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 38))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 37))
      end

      it "is is fourth down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 4,
          ball_yards: YardsInPitch.new(from_left: 37),
        ))
      end
    end

    describe "when five tackles in a row, no first down" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 38))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 37))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 36))
      end

      it "is is turnover and first down to away team" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 36),
        ))
      end
    end
    describe "when two tackles and first down gained" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 25))
      end

      it "is is turnover and first down to away" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 25),
        ))
      end
    end

    describe "when two tackles, first down gained, then no first down" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 25))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 20))
      end

      it "is is second down to away" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 2,
          ball_yards: YardsInPitch.new(from_left: 20),
        ))
      end
    end

    describe "when two tackles, then away touchdown" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 25))
        match_state.away_touchdown
      end

      it "is is away kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :kickoff,
          attempt: 0,
          ball_yards: YardsInPitch.new(from_right: 35),
        ))
      end
    end

    describe "when tackle, then marker not crossed but turn over" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
      end

      it "is is away kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 40),
        ))
      end
    end

    describe "when tackle, then marker crossed but turn over" do
      before(:each) do
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 20))
      end

      it "is is away kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 20),
        ))
      end
    end
  end

  describe "home cases" do
    describe "when kickoff ends with return without touchdown" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
      end

      it "is is first down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 40),
        ))
      end
    end

    describe "when two tackles in a row, no first down" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 41))
      end

      it "is is second down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 2,
          ball_yards: YardsInPitch.new(from_left: 41),
        ))
      end
    end

    describe "when three tackles in a row, no first down" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 41))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 42))
      end

      it "is is third down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 3,
          ball_yards: YardsInPitch.new(from_left: 42),
        ))
      end
    end

    describe "when four tackles in a row, no first down" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 41))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 42))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 43))
      end

      it "is is fourth down" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 4,
          ball_yards: YardsInPitch.new(from_left: 43),
        ))
      end
    end

    describe "when five tackles in a row, no first down" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 41))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 42))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 43))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 44))
      end

      it "is is turnover and first down to away team" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 44),
        ))
      end
    end

    describe "when two tackles and first down gained" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 55))
      end

      it "is is turnover and first down to home" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 55),
        ))
      end
    end

    describe "when two tackles, first down gained, then no first down" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 55))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 60))
      end

      it "is is second down to home" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :attempt,
          attempt: 2,
          ball_yards: YardsInPitch.new(from_left: 60),
        ))
      end
    end

    describe "when two tackles, then away touchdown" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 55))
        match_state.home_touchdown
      end

      it "is is home kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :home,
          type: :kickoff,
          attempt: 0,
          ball_yards: YardsInPitch.new(from_left: 35),
        ))
      end
    end


    describe "when tackle, then marker not crossed but turn over" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 40))
      end

      it "is is away kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 40),
        ))
      end
    end

    describe "when tackle, then marker crossed but turn over" do
      before(:each) do
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 40))
        match_state.home_possesion_and_tackled(YardsInPitch.new(from_left: 39))
        match_state.away_possesion_and_tackled(YardsInPitch.new(from_left: 60))
      end

      it "is is away kickoff" do
        expect(next_action_setup).to eq(ActionSetup.new(
          team: :away,
          type: :attempt,
          attempt: 1,
          ball_yards: YardsInPitch.new(from_left: 60),
        ))
      end
    end
  end

  describe "longer mixed example"
end
