require "football_manager"

RSpec.describe MatchGenerator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new(position: "K", name: "Przemek") }
    let(:returner) { Player.new(position: "KR", name: "Bartek") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker, returner: nil) }
    let(:roster_2) { Roster.new(team: team_2, kicker: nil, returner: returner) }
    let(:return_event_generator) { ScoringReturnEventGenerator.new }
    let(:generators_params) { { return: return_event_generator } }
    let(:event_generators) { EventGenerators.new(generators_params) }
    let(:kickoff_generator) { KickoffGenerator.new }
    let(:match_generator) {
      MatchGenerator.new(kickoff_generator: kickoff_generator,
                         event_generators: event_generators)
    }

    subject(:match) { match_generator.generate(roster_1, roster_2) }

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
end
