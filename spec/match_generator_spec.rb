require "football_manager"

RSpec.describe MatchGenerator do
  let(:team_1) { Team.new }
  let(:team_2) { Team.new }
  let(:kicker) { Player.new(position: "K", name: "Krzysiek") }
  let(:returner) { Player.new(position: "KR", name: "Robert") }
  let(:center) { Player.new(position: "C", name: "Cezary") }
  let(:qb) { Player.new(position: "QB", name: "Qba") }
  let(:roster_1) { Roster.new(team: team_1, kicker: kicker) }
  let(:roster_2) { Roster.new(team: team_2, returner: returner, center: center, qb: qb) }
  let(:generators_params) { {} }
  let(:action_generator) { ActionGenerator.new(phase_generators) }
  let(:phase_generators) { PhaseGenerators.new(generators_params) }
  let(:match_generator) {
    MatchGenerator.new(action_generator: action_generator,
                       home_roster: roster_1,
                       away_roster: roster_2)
  }

  describe "#generate_next" do
    describe "initially" do
      before(:each) { match_generator.generate_next }

      it "generates 1 action" do
        expect(match_generator.match.actions.length).to be(1)
      end

      it "generates default kickoff" do
        expect(match_generator.match.actions.first).to eq(
          Action.new(starting_team: team_1,
                     starting_yards: YardsInPitch.new(from_left: 35),
                     ending_yards: YardsInPitch.new(from_left: 55),
                     phases: [
                       KickoffPhase.new(kicker: kicker, yards_from: Yards.new(35), yards_diff: Yards.new(50), next_phase: :reception, time_in_seconds: 15),
                       ReceptionPhase.new(player: returner, yards_diff: Yards.new(0), next_phase: :return, time_in_seconds: 0),
                       ReturnPhase.new(returner: returner, yards_diff: Yards.new(-30), next_phase: :tackle, time_in_seconds: 15),
                       TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                     ])
        )
      end
    end

    describe "when default kickoff generated" do
      before(:each) { match_generator.generate_next }

      describe "when generate another action" do
        before(:each) { match_generator.generate_next }

        it "generates second action, two action in total" do
          expect(match_generator.match.actions.length).to be(2)
        end

        it "generates default run" do
          expect(match_generator.match.actions[1]).to eq(
            Action.new(starting_team: team_2,
                       starting_yards: YardsInPitch.new(from_left: 55),
                       ending_yards: YardsInPitch.new(from_left: 65),
                       phases: [
                         SnapPhase.new(snaper: center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
                         RunPhase.new(runner: qb, yards_diff: Yards.new(20), next_phase: :tackle, time_in_seconds: 30),
                         TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                       ])
          )
        end
      end
    end

    describe "when two default actions generated" do
      before(:each) do
        2.times { match_generator.generate_next }
      end

      describe "when generate another action" do
        before(:each) { match_generator.generate_next }

        it "generates third action, three action in total" do
          expect(match_generator.match.actions.length).to be(3)
        end

        it "generates default run" do
          expect(match_generator.match.actions[2]).to eq(
            Action.new(starting_team: team_2,
                       starting_yards: YardsInPitch.new(from_left: 65),
                       ending_yards: YardsInPitch.new(from_left: 75),
                       phases: [
                         SnapPhase.new(snaper: center, yards_diff: Yards.new(-10), next_phase: :run, time_in_seconds: 0),
                         RunPhase.new(runner: qb, yards_diff: Yards.new(20), next_phase: :tackle, time_in_seconds: 30),
                         TacklePhase.new(yards_diff: Yards.new(0), next_phase: nil, time_in_seconds: 0),
                       ])
          )
        end
      end
    end
  end

  describe "#generate_whole" do
    before(:each) { match_generator.generate_whole }

    it "generates 30 actions (each default action take 30 seconds)" do
      expect(match_generator.match.actions.length).to eq(30)
    end
  end
end
