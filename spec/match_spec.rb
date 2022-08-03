require "football_manager"

RSpec.describe Match do
  let(:team_1) { Team.new }
  let(:team_2) { Team.new }
  let(:kicker) { Player.new(position: "K", name: "Przemek") }
  let(:returner) { Player.new(position: "KR", name: "Bartek") }
  let(:roster_1) { Roster.new(team: team_1, kicker: kicker, returner: nil) }
  let(:roster_2) { Roster.new(team: team_2, kicker: nil, returner: returner) }
  let(:generators_params) { {} }
  let(:kickoff_generator) { KickoffGenerator.new() }
  let(:event_generators) { PhaseGenerators.new(generators_params) }
  let(:kickoff) { kickoff_generator.generate(roster_1, roster_2, event_generators) }

  let(:match) { Match.new }

  describe "#next_action" do
    subject(:next_action) { match.next_action }

    it "starts with team 1 kickoff" do
      expect(match.next_action).to eq(:team_1_kickoff)
    end

    describe "after non scoring kickoff" do
      it "after kickoff its team 2 attepmt" do
        match.add_action(kickoff)
        expect(match.next_action).to eq(:team_2_attempt)
      end
    end

    describe "after scoring kickoff" do
      let(:return_event_generator) { ScoringReturnPhaseGenerator.new }
      let(:generators_params) { { return: return_event_generator } }

      it "after kickoff its team 2 attepmt" do
        match.add_action(kickoff)
        expect(match.next_action).to eq(:team_1_kickoff)
      end
    end
  end
end
