require "football_manager"

RSpec.describe KickoffGenerator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new("K", "Przemek") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker) }
    let(:roster_2) { Roster.new(team: team_2) }
    let(:generators_params) { {} }
    let(:event_generators) { EventGenerators.new(generators_params) }
    let(:kickoff_generator) { KickoffGenerator.new }

    it "generates kickoff off with proper data" do
      kickoff = kickoff_generator.generate(roster_1, roster_2, event_generators)
      expect(kickoff).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                                KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                                ReceptionEvent.new,
                                                ReturnEvent.new(yards_returned: Yards.new(30)),
                                                TackleEvent.new,
                                              ]))
    end

    describe "when other generator provided" do
      let(:return_event_generator) { ConstantReturnEventGenerator.new(yards_returned: 40) }
      let(:generators_params) { { return: return_event_generator } }

      it "generates kickoff off with different data" do
        kickoff = kickoff_generator.generate(roster_1, roster_2, event_generators)
        expect(kickoff).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                                  KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                                  ReceptionEvent.new,
                                                  ReturnEvent.new(yards_returned: Yards.new(40)),
                                                  TackleEvent.new,
                                                ]))
      end
    end

    describe "when random generator provided" do
      let(:return_event_generator) { RandomReturnEventGenerator.new }
      let(:generators_params) { { return: return_event_generator } }

      it "generates kickoff off with random data" do
        kickoff = kickoff_generator.generate(roster_1, roster_2, event_generators)
        expect(kickoff).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                                  KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                                  ReceptionEvent.new,
                                                  ReturnEvent.new(yards_returned: YardsFromRange.new(30, 50)),
                                                  TackleEvent.new,
                                                ]))
      end
    end

    describe "when kickoff event generator provided" do
      let(:kickoff_event_generator) { ConstantKickoffEventGenerator.new(yards_travelled: 15) }
      let(:generators_params) { { kickoff: kickoff_event_generator } }

      it "generates kickoff off with different data " do
        kickoff = kickoff_generator.generate(roster_1, roster_2, event_generators)
        expect(kickoff).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                                  KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(15)),
                                                  ReceptionEvent.new,
                                                  ReturnEvent.new(yards_returned: Yards.new(30)),
                                                  TackleEvent.new,
                                                ]))
      end
    end
  end
end
