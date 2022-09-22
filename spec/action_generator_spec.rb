require "football_manager"

RSpec.describe ActionGenerator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:center) { Player.new(position: "C", name: "Cezary") }
    let(:qb) { Player.new(position: "QB", name: "Qba") }
    let(:roster_1) { Roster.new(team: team_1, center: center, qb: qb) }
    let(:roster_2) { Roster.new(team: team_2) }
    let(:starting_yards) { YardsInPitch.new(from_left: 50) }
    let(:generators_params) { {} }
    let(:phase_generators) { PhaseGenerators.new(generators_params) }
    let(:action_generator) { ActionGenerator.new(phase_generators) }

    subject(:action) { action_generator.generate(roster_1, roster_2, starting_yards, :snap) }

    it "generates action with default data" do
      expect(action).to eq(Action.new(starting_team: team_1,
                                      starting_yards: YardsInPitch.new(from_left: 50),
                                      ending_yards: YardsInPitch.new(from_left: 60),
                                      phases: [
                                        SnapPhase.new(snaper: center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
                                        RunPhase.new(runner: qb, yards_diff: Yards.new(20), next_phase: :tackle, time_in_seconds: 30),
                                        TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                                      ]))
    end
  end
end
