require "./spec/factories"

RSpec.describe DebugActionPresenter do
  let(:presenter) { DebugActionPresenter.new }
  subject(:description) { presenter.present(action) }

  describe "with default kickoff" do
    let(:action) { Factory.new.default_kickoff }

    it "generates text description" do
      expect(description).to eq("start at 35 yards
[Kickoff] Kicker=Krzysiek; YardsFrom=35; YardsDiff=20; NextPhase=reception; TimeInSeconds=15;
[Reception] Player=Robert 2; YardsDiff=0; NextPhase=return; TimeInSeconds=0;
[Return] Returner=Robert 2; YardsDiff=-30; NextPhase=tackle; TimeInSeconds=15;
[Tackle] YardsDiff=0; NextPhase=; TimeInSeconds=0;
end of action at 25 yards")
    end
  end

  describe "with another action" do
    let(:team) { Team.new }
    let(:snaper) { Player.new(position: "C", name: "Snaper") }
    let(:runner) { Player.new(position: "RB", name: "Robert") }
    let(:action) do
      Action.new(
        starting_team: team,
        starting_yards: YardsInPitch.new(from_left: 50),
        ending_yards: YardsInPitch.new(from_left: 51),
        phases: [
          SnapPhase.new(snaper: snaper, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
          RunPhase.new(runner: runner, yards_diff: Yards.new(11), next_phase: :tackle, time_in_seconds: 30),
          TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
        ],
      )
    end

    it "generates text description" do
      expect(description).to eq("start at 50 yards
[Snap] Snaper=Snaper; YardsDiff=-10; NextPhase=run; TimeInSeconds=0;
[Run] Runner=Robert; YardsDiff=11; NextPhase=tackle; TimeInSeconds=30;
[Tackle] YardsDiff=0; NextPhase=; TimeInSeconds=0;
end of action at 51 yards")
    end
  end
end
