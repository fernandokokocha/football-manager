require "football_manager"

RSpec.describe MatchGenerator do
  let(:team_1) { Team.new }
  let(:team_2) { Team.new }
  let(:kicker) { Player.new(position: "K", name: "Przemek") }
  let(:returner) { Player.new(position: "KR", name: "Bartek") }
  let(:roster_1) { Roster.new(team: team_1, kicker: kicker, returner: nil) }
  let(:roster_2) { Roster.new(team: team_2, kicker: nil, returner: returner) }
  let(:generators_params) { {} }
  let(:action_generator) { ActionGenerator.new() }
  let(:event_generators) { PhaseGenerators.new(generators_params) }
  let(:match_generator) {
    MatchGenerator.new(action_generator: action_generator,
                       event_generators: event_generators,
                       offence: roster_1,
                       defence: roster_2)
  }

  describe "#initialize" do
    subject(:match) { match_generator.match }

    it "starts with kickoff" do
      expect(match.next_action).to eq(:kickoff)
    end

    it "starts with home team offence" do
      expect(match.ball_possession).to eq(roster_1)
    end

    it "starts with 35 from left" do
      expect(match.next_yards).to eq(YardsInPitch.new(from_left: 35))
    end
  end

  describe "#generate_next" do
    let(:return_event_generator) { ScoringReturnPhaseGenerator.new }
    let(:generators_params) { { return: return_event_generator } }

    subject(:match) { match_generator.generate_next }

    it "generates 1 action" do
      expect(match.actions.length).to be(1)
    end

    it "generates action as kickoff" do
      expect(match.actions.first).to be_kickoff
    end

    it "generates match with score 0-6" do
      expect(match.score).to eq("0-6")
    end

    it "generates match where team 1 has ball possession" do
      expect(match.ball_possession).to eq(roster_1)
    end

    it "generates match where next action is kickoff" do
      expect(match.next_action).to eq(:kickoff)
    end

    it "generates next yardage" do
      expect(match.next_yards).to eq(YardsInPitch.new(from_left: 35))
    end
  end

  describe "#generate" do
    subject(:match) { match_generator.generate }

    describe "when each kickoff ends with return touchdown" do
      let(:return_event_generator) { ScoringReturnPhaseGenerator.new }
      let(:generators_params) { { return: return_event_generator } }

      it "generates 30 actions" do
        expect(match.actions.length).to be(30)
      end

      it "generates each action as kickoff" do
        expect(match.actions).to all(be_kickoff)
      end

      it "generates match with score 0-180 - each action is a 6 pt TD for away team" do
        expect(match.score).to eq("0-180")
      end
    end

    describe "when first kickoff ends with return touchdown and lasts whole quarter" do
      let(:return_event_generator) { ScoringReturnPhaseGenerator.new }
      let(:generators_params) { { return: return_event_generator } }
      let(:action_generator) { ActionGenerator.new(time_in_seconds: 15 * 60) }

      it "generates 1 action" do
        expect(match.actions.length).to be(1)
      end

      it "generates action as kickoff" do
        expect(match.actions).to all(be_kickoff)
      end

      it "generates match with score 0-6" do
        expect(match.score).to eq("0-6")
      end
    end
  end
end
