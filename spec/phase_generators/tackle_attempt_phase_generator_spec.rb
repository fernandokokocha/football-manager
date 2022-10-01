RSpec.describe SkillBasedTackleAttemptPhaseGenerator do
  let(:team_1) { Team.new }
  let(:team_2) { Team.new }
  let(:qb) { Player.new(position: "QB", name: "Qba") }
  let(:left_tackle) { Player.new(position: "LT", name: "Lew Talcki") }
  let(:roster_1) { Roster.new(team: team_1, qb: qb) }
  let(:roster_2) { Roster.new(team: team_2, left_tackle: left_tackle) }
  let(:current_yards) { 35 }
  let(:progress) { ProgressCountup.new }
  let(:phase_generator) { SkillBasedTackleAttemptPhaseGenerator.new(1) }
  subject(:run_phase) { phase_generator.call(roster_1, roster_2, current_yards, progress) }

  it "generates run ending with tackle" do
    expect(run_phase).to eq(TackleAttemptPhase.new(
      ball_holder: qb,
      tackle: left_tackle,
      yards_diff: Yards.new(0),
      next_phase: :sprint,
      time_in_seconds: 2,
    ))
  end
end
