require "football_manager"

RSpec.describe KickoffGenerator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new(position: "K", name: "Przemek") }
    let(:returner) { Player.new(position: "KR", name: "Bartek") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker) }
    let(:roster_2) { Roster.new(team: team_2, returner: returner) }
    let(:generators_params) { {} }
    let(:event_generators) { PhaseGenerators.new(generators_params) }
    let(:kickoff_generator) { KickoffGenerator.new }

    subject(:kickoff) { kickoff_generator.generate(roster_1, roster_2, event_generators) }

    it "generates kickoff off with default data" do
      expect(kickoff).to eq(Action.new(starting_team: team_1,
                                              starting_yards: YardsInPitch.new(from_left: 35),
                                              ending_yards: YardsInPitch.new(from_left: 55),
                                              phases: [
                                                KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_phase: :reception),
                                                ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return),
                                                ReturnPhase.new(returner: returner, yards_diff: Yards.new(-30), next_phase: :tackle),
                                                TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil),
                                              ],
                                              time_in_seconds: 30))
    end

    describe "when other generator provided" do
      let(:return_event_generator) { ConstantReturnPhaseGenerator.new(yards_returned: 40) }
      let(:generators_params) { { return: return_event_generator } }

      it "generates kickoff off with different data" do
        expect(kickoff).to eq(Action.new(starting_team: team_1,
                                                starting_yards: YardsInPitch.new(from_left: 35),
                                                ending_yards: YardsInPitch.new(from_left: 45),
                                                phases: [
                                                  KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_phase: :reception),
                                                  ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return),
                                                  ReturnPhase.new(returner: returner, yards_diff: Yards.new(-40), next_phase: :tackle),
                                                  TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil),
                                                ],
                                                time_in_seconds: 30))
      end
    end

    describe "when random generator provided" do
      let(:return_event_generator) { RandomReturnPhaseGenerator.new }
      let(:generators_params) { { return: return_event_generator } }

      it "generates kickoff off with random data" do
        ending_yards_num = 85 + kickoff.phases[2].yards_diff.number
        expect(kickoff).to eq(Action.new(starting_team: team_1,
                                                starting_yards: YardsInPitch.new(from_left: 35),
                                                ending_yards: YardsInPitch.new(from_left: ending_yards_num),
                                                phases: [
                                                  KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_phase: :reception),
                                                  ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return),
                                                  ReturnPhase.new(returner: returner, yards_diff: YardsFromRange.new(-50, -30), next_phase: :tackle),
                                                  TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil),
                                                ],
                                                time_in_seconds: 30))
      end
    end

    describe "when kickoff event generator provided" do
      let(:kickoff_event_generator) { ConstantKickoffPhaseGenerator.new(yards_travelled: 15) }
      let(:generators_params) { { kickoff: kickoff_event_generator } }

      it "generates kickoff off with different data " do
        expect(kickoff).to eq(Action.new(starting_team: team_1,
                                                starting_yards: YardsInPitch.new(from_left: 35),
                                                ending_yards: YardsInPitch.new(from_left: 20),
                                                phases: [
                                                  KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(15), next_phase: :reception),
                                                  ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return),
                                                  ReturnPhase.new(returner: returner, yards_diff: Yards.new(-30), next_phase: :tackle),
                                                  TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil),
                                                ],
                                                time_in_seconds: 30))
      end
    end

    describe "when scoring return event generator provided" do
      let(:return_event_generator) { ScoringReturnPhaseGenerator.new }
      let(:generators_params) { { return: return_event_generator } }

      it "generates kickoff off with different data " do
        expect(kickoff).to eq(Action.new(starting_team: team_1,
                                                starting_yards: YardsInPitch.new(from_left: 35),
                                                ending_yards: YardsInPitch.new(from_left: 0),
                                                phases: [
                                                  KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_phase: :reception),
                                                  ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return),
                                                  ReturnPhase.new(returner: returner, yards_diff: Yards.new(-85), next_phase: :touchdown),
                                                  TouchdownPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: nil),
                                                ],
                                                time_in_seconds: 30))
      end
    end
  end
end
