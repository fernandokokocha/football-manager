require "football_manager"

RSpec.describe MatchGenerator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new(position: "K", name: "Przemek") }
    let(:returner) { Player.new(position: "KR", name: "Bartek") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker, returner: nil) }
    let(:roster_2) { Roster.new(team: team_2, kicker: nil, returner: returner) }
    let(:generators_params) { {} }
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
  end
end
