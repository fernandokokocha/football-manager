require "football_manager"

RSpec.describe Generator do
  describe "#generate" do
    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:kicker) { Player.new("K", "Przemek") }
    let(:roster_1) { Roster.new(team: team_1, kicker: kicker) }
    let(:roster_2) { Roster.new(team: team_2) }
    let(:generator) { Generator.new }

    it "generates kickoff off with proper data" do
      match = generator.generate(roster_1, roster_2)
      expect(match).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                              KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                              ReceptionEvent.new,
                                              ReturnEvent.new(yards_returned: Yards.new(30)),
                                              TackleEvent.new,
                                            ]))
    end

    it "generates kickoff off with different data when other generator provided" do
      return_event_generator = ConstantReturnEventGenerator.new(yards_returned: 40)
      match = generator.generate(roster_1, roster_2, return_event_generator)
      expect(match).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                              KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                              ReceptionEvent.new,
                                              ReturnEvent.new(yards_returned: Yards.new(40)),
                                              TackleEvent.new,
                                            ]))
    end

    it "generates kickoff off with random data when random generator provided" do
      return_event_generator = RandomReturnEventGenerator.new
      match = generator.generate(roster_1, roster_2, return_event_generator)
      expect(match).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                              KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(50)),
                                              ReceptionEvent.new,
                                              ReturnEvent.new(yards_returned: YardsFromRange.new(30, 50)),
                                              TackleEvent.new,
                                            ]))
    end

    it "generates kickoff off with different data when kickoff event generator provided" do
      return_event_generator = DefaultReturnEventGenerator.new
      kickoff_event_generator = ConstantKickoffEventGenerator.new(yards_travelled: 15)
      match = generator.generate(roster_1, roster_2, return_event_generator, kickoff_event_generator)
      expect(match).to eq(KickoffAction.new(offence_team: team_1, phases: [
                                              KickoffEvent.new(kicker: kicker, yards_from: Yards.new(35), yards_travelled: Yards.new(15)),
                                              ReceptionEvent.new,
                                              ReturnEvent.new(yards_returned: Yards.new(30)),
                                              TackleEvent.new,
                                            ]))
    end
  end
end
