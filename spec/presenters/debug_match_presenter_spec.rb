require "./spec/factories"

RSpec.describe DebugMatchPresenter do
  let(:fixtures_factory) { Factory.new }
  let(:presenter) { DebugMatchPresenter.new }
  subject(:description) { presenter.present(match) }

  describe "with default match with one action" do
    let(:match) { fixtures_factory.default_match_one_action }

    it "generates text description" do
      expect(description).to eq("***** MATCH *****
HomeTeamId=#{fixtures_factory.default_team_home.object_id}
AwayTeamId=#{fixtures_factory.default_team_away.object_id}
Actions:
#1
SETUP
kickoff
home
Yards 35
ProgressCountup
DESCRIPTION
start at 35 yards
[Kickoff] Kicker=Krzysiek; YardsFrom=35; YardsDiff=20; NextPhase=reception; TimeInSeconds=15;
[Reception] Player=Robert 2; YardsDiff=0; NextPhase=return; TimeInSeconds=0;
[Return] Returner=Robert 2; YardsDiff=-30; NextPhase=tackle; TimeInSeconds=15;
[Tackle] YardsDiff=0; NextPhase=; TimeInSeconds=0;
end of action at 25 yards")
    end
  end

  describe "with default match" do
    let(:match) { fixtures_factory.default_match }

    it "generates text description" do
      expected = "***** MATCH *****
HomeTeamId=#{fixtures_factory.default_team_home.object_id}
AwayTeamId=#{fixtures_factory.default_team_away.object_id}
"

      expected += fixtures_factory.default_match_actions_description
      expect(description).to eq(expected)
    end
  end
end
